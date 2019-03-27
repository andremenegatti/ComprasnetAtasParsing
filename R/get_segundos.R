#' Obtem medida de tempo em segundos a partir de uma string com registro de lance
#'
#' Funcao util para avaliar intervalo entre lances com precisao.
#'
#' @param date_string  character string com uma data no formato utilizado nas atas ou em formato ISO-8601
#' @param iso_input boolean indicando se o argumento date_string esta em formato ISO-8601 ou nao
#'
#' @return
#' @export
#'
#' @examples
get_segundos <- function(date_string, iso_input = FALSE) {

  if (iso_input == FALSE) {
    toISOdate(date_string = date_string, as_character = FALSE) %>%
      lubridate::seconds()
  } else if (iso_input == TRUE) {
    lubridate::as_datetime(date_string) %>%
      lubridate::seconds()
  }

}
