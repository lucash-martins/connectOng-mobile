import 'package:flutter/material.dart';
import 'package:flutter_application_1/tipo_usuario.dart';

class BuscarDoadorScreen extends StatefulWidget {
  const BuscarDoadorScreen({Key? key}) : super(key: key);

  @override
  State<BuscarDoadorScreen> createState() => _BuscarDoadorScreenState();
}

class _BuscarDoadorScreenState extends State<BuscarDoadorScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Doador> _allDoadores = [
    Doador(
      nome: 'João Silva',
      email: 'joao@email.com',
      telefone: '11 99999-1111',
      endereco: 'Limeira',
    ),
    Doador(
      nome: 'Maria Oliveira',
      email: 'maria@email.com',
      telefone: '11 98888-2222',
      endereco: 'Campinas',
    ),
    Doador(
      nome: 'Carlos Santos',
      email: 'carlos@email.com',
      telefone: '19 97777-3333',
      endereco: 'Americana',
    ),
    Doador(
      nome: 'Ana Paula',
      email: 'ana@email.com',
      telefone: '19 96666-4444',
      endereco: 'Limeira',
    ),
    Doador(
      nome: 'Lucas Henrique',
      email: 'lucas@email.com',
      telefone: '19 95555-5555',
      endereco: 'Piracicaba',
    ),

  ];

  List<Doador> _filteredDoadores = [];
  bool _buscou = false;

  @override
  void initState() {
    super.initState();
    // Não mostra nada inicialmente
    _searchController.addListener(() {
      setState(() {
        _buscou = false;
      });
    });
  }

  void _buscarDoadores() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _buscou = true;
      if (query.isEmpty) {
        _filteredDoadores = [];
      } else {
        _filteredDoadores = _allDoadores.where((doador) =>
          doador.nome.toLowerCase().contains(query)
        ).toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildDoadorTile(Doador doador) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Color(0xFF0A8449),
          child: Icon(Icons.person, color: Colors.white),
        ),
        title: Text(doador.nome, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Cidade: ${doador.endereco}'),
            Text('Email: ${doador.email}'),
            Text('Telefone: ${doador.telefone}'),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Doador'),
        backgroundColor: const Color(0xFF0A8449),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _buscarDoadores,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0A8449),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Pesquisar', style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: !_buscou
                  ? const SizedBox.shrink()
                  : _filteredDoadores.isEmpty
                      ? const Center(
                          child: Text(
                            'Nenhum doador encontrado',
                            style: TextStyle(fontSize: 18),
                          ),
                        )
                      : ListView.separated(
                          itemCount: _filteredDoadores.length,
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (context, index) {
                            return _buildDoadorTile(_filteredDoadores[index]);
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
