#' Verifica se a ata e de um pregao que possui atas complementares ou nao
#'
#' Verifica se o pregao da ata passada como argumento possui atas complementares ou nao.
#' Importante pois a existencia de atas complementares muda a estrutura do codigo html.
#'
#' @param html_doc um documento xml referente a ata de um pregao eletronico
#'
#' @return Retorna TRUE se o pregao possui ata complementar e FALSE caso contrario.
#' @export
#'
#' @examples
possui_ata_complementar <- function(html_doc) {
  html_node(html_doc, xpath = '/html/body/table/tbody/tr/td[2]') %>%
    html_text() %>%
    str_detect('Este preg.*o possui \\d+')
}
