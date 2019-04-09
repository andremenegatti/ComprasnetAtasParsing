#' Captura codigo da UASG
#'
#' @param html_doc documento xml referente a ata de um pregao eletronico
#' @param possui_ata_complementar boolean indicando se o pregao possui ata complementar
#'   complementar ou nao; se NA, a funcao ira verificar no html da ata
#'
#' @return String de 6 digitos com o codigo da UASG
#'
#' @export
get_couasg <- function(html_doc, possui_ata_complementar = NA) {

  if (is.na(possui_ata_complementar)) {
    xpath_base <- if_else(possui_ata_complementar(html_doc), '/html/body/table[3]', '/html/body/table[2]')
  } else {
    xpath_base <- if_else(possui_ata_complementar, '/html/body/table[3]', '/html/body/table[2]')
  }

  id_pregao <- html_node(html_doc, xpath = str_c(xpath_base, '/tbody/tr/td')) %>% html_text() %>%
    str_remove_all(' ') %>%
    str_extract('\\d+(?=\\.\\d+)') %>%
    str_pad(width = 6, side = 'left', pad = '0')

}
