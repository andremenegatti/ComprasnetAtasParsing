#' Captura o paragrafo final da ata
#'
#' @param html_doc documento xml referente a ata de um pregao eletronico
#'
#' @return String com o paragrafo final da ata
#' @export
get_encerramento <- function(html_doc) {

  html_node(html_doc, xpath = '/html/body/table[last()-2]/tbody/tr[last()-2]') %>%
    html_text()

}
