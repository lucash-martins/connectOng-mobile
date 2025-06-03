import 'package:flutter/material.dart';
import '../tipo_usuario.dart';

class BuscarReceptorScreen extends StatefulWidget {
  const BuscarReceptorScreen({Key? key}) : super(key: key);

  @override
  State<BuscarReceptorScreen> createState() => _BuscarReceptorScreenState();
}

class _BuscarReceptorScreenState extends State<BuscarReceptorScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Doador> _allReceptores = [
    Doador(
      nome: 'Lucas Silva',
      email: 'lucas@email.com',
      telefone: '11 99999-1234',
      endereco: 'Rua A, 123 - Limeira',
    ),
    Doador(
      nome: 'Gabriel Oliveira',
      email: 'gabriel@email.com',
      telefone: '11 98888-4321',
      endereco: 'Av. Central, 500 - Campinas',
    ),
    Doador(
      nome: 'Luan Santos',
      email: 'luan@email.com',
      telefone: '11 97777-0000',
      endereco: 'Rua das Rosas, 88 - Americana',
    ),
  ];

  List<Doador> _resultados = [];

  void _buscarDoador() {
    final query = _searchController.text.trim().toLowerCase();
    setState(() {
      _resultados = _allReceptores
          .where((r) => r.endereco.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildDoadorCard(Doador d) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(d.nome, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Email: [${d.email}]'),
            Text('Telefone: ${d.telefone}'),
            Text('Endereço: ${d.endereco}'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buscar Receptor')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Endereço do Receptor',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _buscarDoador,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0A8449),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Pesquisar', style: TextStyle(fontSize: 16)),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _resultados.isEmpty
                  ? const Center(child: Text('Nenhuma pessoa encontrada.', style: TextStyle(fontSize: 16)))
                  : ListView.builder(
                      itemCount: _resultados.length,
                      itemBuilder: (context, index) {
                        return _buildDoadorCard(_resultados[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
