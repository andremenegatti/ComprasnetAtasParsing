#' Converter valores disponiveis no historico de lances para formato numerico
#'
#' @param string character string com o valor do lance, tal como disponivel nas atas
#'
#' @return numeric
#' @export
#'
#' @examples
limpar_valores <- function(string) {

  str_extract(string,
              pattern = '(\\d{1,3}\\.)*\\d{1,3},\\d.*') %>%
    str_remove_all(' |\\.') %>%
    str_replace(pattern = ',(?=\\d+$)', replacement = '\\.') %>%
    as.numeric()
}
