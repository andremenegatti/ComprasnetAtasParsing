#' Captura numero do pregao
#'
#' Captura o numero do pregao a partir do numero exibido no canto superior direito da ata. O numero do pregao corresponde ao numero entre o primeiro e segundo pontos, com zero-padding para completar 10 digitos.
#'
#' @param html_doc documento xml referente a ata de um pregao eletronico
#' @param possui_ata_complementar boolean indicando se o pregao possui ata complementar
#'   complementar ou nao; se NA, a funcao ira verificar no html da ata
#'
#' @return String de 10 digitos com o numero do pregao
#' @export
#'
#' @examples
get_numpreg <- function(html_doc, possui_ata_complementar = NA) {

  if (is.na(possui_ata_complementar)) {
    xpath_base <- if_else(possui_ata_complementar(html_doc), '/html/body/table[3]', '/html/body/table[2]')
  } else {
    xpath_base <- if_else(possui_ata_complementar, '/html/body/table[3]', '/html/body/table[2]')
  }

  matches <- html_node(html_doc, xpath = str_c(xpath_base, '/tbody/tr/td')) %>% html_text() %>%
    str_remove_all(' ') %>%
    str_match('\\d+\\.(\\d+)')

  str_c(matches[1,2] %>% str_pad(width = 10, side = 'left', pad = '0'))

}
