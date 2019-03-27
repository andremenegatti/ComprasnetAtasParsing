#' Captura o numero identificador do pregao (16 digitos)
#'
#' Funcao para capturar o id do pregao. O id do pregao possui 16 digitos, sendo os 6 primeiros correspondentes ao codigo da UASG e os 10 ultimos referentes ao numero do pregao (com zero-padding)
#'
#' @param html_doc documento xml referente a ata de um pregao eletronico
#' @param possui_ata_complementar boolean indicando se o pregao possui ata complementar
#'   complementar ou nao; se NA, a funcao ira verificar no html da ata
#'
#' @return string com o numero identificador de 16 digitos
#' @export
#'
#' @examples
get_id_pregao <- function(html_doc, possui_ata_complementar = NA) {

  if (is.na(possui_ata_complementar)) {
    xpath_base <- if_else(possui_ata_complementar(html_doc), '/html/body/table[3]', '/html/body/table[2]')
  } else {
    xpath_base <- if_else(possui_ata_complementar, '/html/body/table[3]', '/html/body/table[2]')
  }

  matches <- html_node(html_doc, xpath = str_c(xpath_base, '/tbody/tr/td')) %>% html_text() %>%
    str_remove_all(' ') %>%
    str_match('(\\d+)\\.(\\d+)')

  str_c(matches[1,2] %>% str_pad(width = 6, side = 'left', pad = '0'),
        matches[1,3] %>% str_pad(width = 10, side = 'left', pad = '0'))

}
