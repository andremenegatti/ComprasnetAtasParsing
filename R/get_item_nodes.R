#' Identifica os xml nodes dos itens
#'
#' @param html_doc documento xml referente a ata de um pregao eletronico
#' @param possui_ata_complementar boolean indicando se o pregao possui ata complementar
#'   complementar ou nao; se NA, a funcao ira verificar no html da ata
#'
#' @return nodeset com todos os nodes de itens listados no inicio da ata
#' @export
get_item_nodes <- function(html_doc, possui_ata_complementar = NA) {

  if (is.na(possui_ata_complementar)) {
    xpath_base <- if_else(possui_ata_complementar(html_doc), '/html/body/table[3]', '/html/body/table[2]')
  } else {
    xpath_base <- if_else(possui_ata_complementar, '/html/body/table[3]', '/html/body/table[2]')
  }

  html_nodes(html_doc, xpath = str_c(xpath_base, '/tbody/tr[4]/td//td[contains(text(), "Item: ")]'))

}
