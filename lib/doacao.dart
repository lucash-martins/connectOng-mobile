class Doacao {
  final String nome;
  final String descricao;
  final int quantidade;
  final String categoria;
  final String tipo;
  final bool urgente;
  final bool novo;

  Doacao({
    required this.nome,
    required this.descricao,
    required this.quantidade,
    required this.categoria,
    required this.tipo,
    required this.urgente,
    required this.novo,
  });
}