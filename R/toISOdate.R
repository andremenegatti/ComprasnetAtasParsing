options(digits.secs = 3)

#' Converte string de data do historico de lances para o formato ISO-8601
#'
#' @param date_string uma string de caracteres representando datas no formato
#'   utilizado no historico de lances
#' @param as_character boolean que indica que o resultado será em formato de
#'   caracteres ou data
#'
#' @return Se as_character = TRUE, retorna uma string de caracteres com a data
#'   em formato ISO-8601. Se as_character = FALSE, retorna objeto datetime
#'
#' @export
toISOdate <- function(date_string, as_character = TRUE) {

  if (as_character) {
    date_string %>%
      str_replace(pattern = '(?<=\\d{2}:\\d{2}:\\d{2}):(?=\\d+$)',
                  replacement = '\\.') %>%
      lubridate::as_datetime(format = '%d/%m/%Y %H:%M:%OS') %>%
      as.character()
  } else {
    date_string %>%
      str_replace(pattern = '(?<=\\d{2}:\\d{2}:\\d{2}):(?=\\d+$)',
                  replacement = '\\.') %>%
      lubridate::as_datetime(format = '%d/%m/%Y %H:%M:%OS')
  }
}
