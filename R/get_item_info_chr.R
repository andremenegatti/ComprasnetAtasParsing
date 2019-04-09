#' Captura uma informacao especifica referente a um item do pregao
#'
#' Funcao para capturar uma informacao especifica e unidimensional (string) referente a um item.
#'
#' @param item_node node do item cujos dados serao extraidos
#' @param item_info string indicando qual informacao se deseja capturar
#'
#' @return string com a informacao desejada, caso encontrada
#' @seealso para capturar dados referentes a itens disponiveis em formato de tabelas (e.g, historico de lances e propostas), ver funcao get_item_info_dfs
#' @export
get_item_info_chr <- function(item_node, item_info) {

  if (!item_info %in% names(xpaths)) {
    stop("o argumento \'item_info\' deve ser um dos seguintes: (i) item_id; (ii) descricao; (iii) descricao_complementar;
         (iv) quantidade; (v) valor_estimado; (vi) unidade_fornecimento; (viii) tratamento_diferenciado; (ix) decreto_7174;
         (x) margem_preferencia; or (xi) situacao.")
  }

  rvest::html_node(item_node, xpath = xpaths[[item_info]]) %>%
    rvest::html_text() %>%
    stringr::str_remove_all(char_remove[[item_info]])

}
