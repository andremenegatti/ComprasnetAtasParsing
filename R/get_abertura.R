#' Captura o paragrafo inicial da ata
#'
#' @param html_doc documento xml referente a ata de um pregao eletronico
#' @param possui_ata_complementar boolean indicando se o pregao possui ata complementar
#'   complementar ou nao; se NA, a funcao ira verificar no html da ata
#'
#' @return String com o paragrafo inicial da ata
#'
get_abertura <- function(html_doc, possui_ata_complementar = NA) {

  if (is.na(possui_ata_complementar)) {
    xpath_base <- if_else(possui_ata_complementar(html_doc), '/html/body/table[3]', '/html/body/table[2]')
  } else {
    xpath_base <- if_else(possui_ata_complementar, '/html/body/table[3]', '/html/body/table[2]')
  }

  html_node(html_doc, xpath = str_c(xpath_base, '/tbody/tr/td/table/tbody/tr/td[@class="tex3"]')) %>%
    html_text()

}
