#' Captura informacoes referentes a itens que sao apresentadas no formato de tabelas
#'
#' Funcao utilizada para capturar as seguintes informacoes relativas a itens especificos:
#' * propostas
#' * lances
#' * lances_desempate_ME_EPP
#' * eventos_item
#' @md
#'
#'
#' @param html_doc documento xml referente a ata de um pregao eletronico ou xml_node referente ao item identificado no argumento id_item
#' @param id_item string com o numero do item
#' @param item_info string com a informacao a ser capturada
#'
#' @return dataframe com as informacoes
#' @export
#' @seealso Para capturar informacoes referentes a itens de uma ata, ver get_bid_info_dfs
#' @examples
get_item_info_df <- function(html_doc, id_item, item_info) {

  if (!item_info %in% c("propostas", "lances", "lances_desempate_ME_EPP", "eventos_item")) {
    stop("\'item_info\' parameter must be one of the following: (i) propostas; (ii) lances;
         (iii) lances_desempate_ME_EPP; or (iv) eventos_item.")
  }

  if (item_info == 'propostas') {
    return(get_propostas(html_doc, id_item))

  } else if (item_info == 'lances') {
    return(get_lances(html_doc, id_item))

  } else if (item_info == 'lances_desempate_ME_EPP') {
    return(get_lances_desempate_ME_EPP(html_doc, id_item))

  } else {
    return(get_item_events(html_doc, id_item))
  }

}
