#' Captura data e horario de abertura do pregao
#'
#' Captura data e hora de abertura do pregao, a partir do html da ata ou de string contendo o primeiro paragrafo da ata
#'
#' @param x character string contendo o primeiro paragrafo ou xml_document da ata
#'
#' @return character string com data e hora de abertura do pregao
#' @export
get_data <- function(x) {

  if (!any(class(x) %in% c('character', 'xml_document'))) {
    stop("\'x\' must be a character string or an xml_document")
  }

  if (any(class(x) == 'xml_document')) {
    x <- get_abertura(html_doc)
  }

  matches <- str_match(tolower(x), 's (\\d{2}:\\d{2}) horas do dia (\\d{1,2}) de (.+) de (\\d{4})')

  str_c(matches[1,5],
        '-',
        matches[1,4] %>%
          str_replace('janeiro', '01') %>%
          str_replace('fevereiro', '02') %>%
          str_replace('mar.+o', '03') %>%
          str_replace('abril', '04') %>%
          str_replace('maio', '05') %>%
          str_replace('junho', '06') %>%
          str_replace('julho', '07') %>%
          str_replace('agosto', '08') %>%
          str_replace('setembro', '09') %>%
          str_replace('outubro', '10') %>%
          str_replace('novembro', '11') %>%
          str_replace('dezembro', '12'),
        '-',
        matches[1,3],
        ' ',
        matches[1,2])

}
