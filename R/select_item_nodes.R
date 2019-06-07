#' Selecionar item_nodes de interesse com base em um vetor de indices para acelerar o parsing
#'
#' @param id_item_nodes lista de nodes dos itens, obtida a partir de 'get_info_nodes'
#' @param indices vetor numerico com os indices dos itens de interesse
#'
#' @return lista de nodes dos itens de interesse
#' @export
select_item_nodes <- function(id_item_nodes, indices) {

  if (!is.numeric(indices)) stop("'indices' must be a vector of integers")

  # Tentativa 'naive': hipotese de que ha nodes ordenados para todos os itens
  if (length(id_item_nodes) >= max(indices)) {
    tentativa <- id_item_nodes[indices]
    # Extraindo os verdadeiros indices do subset obtido para checar
    tentativa_indices <- map_chr(.x = tentativa,.f = ~ get_item_info_chr(.x, 'indice_item')) %>%
      as.numeric()
    # Se o metodo simples funcionou, a funcao retorna o conjunto 'tentativa'
    if (identical(indices, tentativa_indices)) return(tentativa)
  }
  # Caso o metodo simples nao tenha funcionado, sera necessario extrair os indices verdadeiros de todos os nodes
  all_indices <- map_chr(.x = id_item_nodes,.f = ~ get_item_info_chr(.x, 'indice_item')) %>%
    as.numeric()

  # Subsetting a lista de nodes (apenas nodes em que o indice 'verdadeiro' esta na incluso no vetor 'indices')
  id_item_nodes[which(all_indices %in% indices)]

}
