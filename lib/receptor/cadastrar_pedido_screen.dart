import 'package:flutter/material.dart';
import 'package:flutter_application_1/pedido.dart';
import 'pedido_card.dart';

class CadastrarPedidoScreen extends StatefulWidget {
  const CadastrarPedidoScreen({super.key});

  @override
  State<CadastrarPedidoScreen> createState() => _CadastrarPedidoScreenState();
}

class _CadastrarPedidoScreenState extends State<CadastrarPedidoScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _nomeDoacao;
  String? _descricaoDoacao;
  int? _quantidade;
  String? _tipoDoacao = 'Material';

  Map<String, bool> _publicosBeneficiados = {
    'Crianças': false,
    'Idosos': false,
    'Animais': false,
    'Comunidade': false,
  };

  String? _categoria = 'Roupas';
  final List<String> _categorias = ['Roupas', 'Alimentos', 'Brinquedos', 'Dinheiro', 'Outros'];

  final List<PedidoDoacao> _pedidos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar Pedido de Doação')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Nome da Doação',
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (val) => _nomeDoacao = val,
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return 'Informe o nome da doação';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Descrição',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 3,
                          onSaved: (val) => _descricaoDoacao = val,
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return 'Informe uma descrição';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Quantidade',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          onSaved: (val) => _quantidade = int.tryParse(val ?? ''),
                          validator: (val) {
                            if (val == null || val.trim().isEmpty) {
                              return 'Informe a quantidade';
                            }
                            final n = int.tryParse(val);
                            if (n == null || n <= 0) {
                              return 'Quantidade deve ser número positivo';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        Text('Tipo de Doação', style: TextStyle(fontWeight: FontWeight.bold)),
                        RadioListTile<String>(
                          title: const Text('Material'),
                          value: 'Material',
                          groupValue: _tipoDoacao,
                          onChanged: (val) {
                            setState(() {
                              _tipoDoacao = val;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('Dinheiro'),
                          value: 'Dinheiro',
                          groupValue: _tipoDoacao,
                          onChanged: (val) {
                            setState(() {
                              _tipoDoacao = val;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('Serviço'),
                          value: 'Serviço',
                          groupValue: _tipoDoacao,
                          onChanged: (val) {
                            setState(() {
                              _tipoDoacao = val;
                            });
                          },
                        ),
                        const SizedBox(height: 24),
                        Text('Público Beneficiado', style: TextStyle(fontWeight: FontWeight.bold)),
                        ..._publicosBeneficiados.keys.map((key) {
                          return CheckboxListTile(
                            title: Text(key),
                            value: _publicosBeneficiados[key],
                            onChanged: (val) {
                              setState(() {
                                _publicosBeneficiados[key] = val ?? false;
                              });
                            },
                          );
                        }).toList(),
                        const SizedBox(height: 24),
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Categoria',
                            border: OutlineInputBorder(),
                          ),
                          value: _categoria,
                          items: _categorias
                              .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              _categoria = val;
                            });
                          },
                          onSaved: (val) => _categoria = val,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Selecione uma categoria';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0A8449),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          onPressed: () {
                            final isValid = _formKey.currentState?.validate() ?? false;
                            if (!isValid) return;

                            _formKey.currentState?.save();

                            final publicosSelecionados = _publicosBeneficiados.entries
                                .where((e) => e.value)
                                .map((e) => e.key)
                                .toList();

                            setState(() {
                              _pedidos.insert(0, PedidoDoacao(
                                nome: _nomeDoacao!,
                                descricao: _descricaoDoacao!,
                                quantidade: _quantidade!,
                                tipo: _tipoDoacao!,
                                publicos: publicosSelecionados,
                                categoria: _categoria!,
                              ));

                              _formKey.currentState?.reset();

                              _tipoDoacao = 'Material';
                              _categoria = 'Roupas';
                              _publicosBeneficiados.updateAll((key, value) => false);
                            });
                          },
                          child: const Text('Salvar Pedido', style: TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  if (_pedidos.isNotEmpty)
                    const Text('Pedidos cadastrados:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  ..._pedidos.map((pedido) => PedidoCard(pedido: pedido)).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
