#' Captura nome do orgao
#'
#' Captura nome do orgao, conforme exibido no inicio da ata, em posicao
#' centralizada.
#'
#' @param html_doc documento xml referente a ata de um pregao eletronico
#' @param possui_ata_complementar boolean indicando se o pregao possui ata
#'   complementar complementar ou nao; se NA, a funcao ira verificar no html da
#'   ata
#'
#' @return string com o nome do orgao. Caso mais de uma linha de informacao sobre
#'   o orgao esteja disponivel na ata, as linhas sao separadas por
#'   ponto-e-virgula.
#' @export
#'
#' @examples
get_orgao <- function(html_doc, possui_ata_complementar = NA) {

  if (is.na(possui_ata_complementar)) {
    xpath_base <- if_else(possui_ata_complementar(html_doc), '/html/body/table[3]', '/html/body/table[2]')
  } else {
    xpath_base <- if_else(possui_ata_complementar, '/html/body/table[3]', '/html/body/table[2]')
  }

  orgao <- html_nodes(html_doc, xpath = str_c(xpath_base, '/tbody/tr/td/table[@class="tex3"]/tbody/tr[@align="center"]/td/text()')) %>%
    html_text() %>%
    str_c(collapse = ' ; ')

  if (length(orgao) != 0) {
    return(orgao)
  } else {
    return(NA)
  }

}
