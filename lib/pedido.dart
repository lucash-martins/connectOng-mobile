class PedidoDoacao {
  final String nome;
  final String descricao;
  final int quantidade;
  final String tipo;
  final List<String> publicos;
  final String categoria;

  PedidoDoacao({
    required this.nome,
    required this.descricao,
    required this.quantidade,
    required this.tipo,
    required this.publicos,
    required this.categoria,
  });
}