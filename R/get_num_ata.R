#' Captura o numero de atas complementares que o pregao possui
#'
#' @param html_doc documento xml referente a ata de um pregao eletronico
#'
#' @return string com o numero de atas complementares do pregao
#' @export
get_num_ata <- function(html_doc) {

  if (!possui_ata_complementar(html_doc)) {
    return('0')
  } else {
    html_node(html_doc, xpath = '/html/body/table[1]') %>%
      html_text() %>%
      str_extract('(?<=possui )\\d+')
  }

}
