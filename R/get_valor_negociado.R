#' Extrai dado de valor negociado a partir do texto do campo 'resultado'
#'
#' @param resultado character string com o resultado de um item, tal como disponivel no comeco das atas
#'
#' @return numeric
#' @seealso para capturar texto de resultado a partir do html, ver get_item_info e get_item_info_chr
#' @export
get_valor_negociado <- function(resultado) {

  if (class(resultado) != 'character') {
    stop("\'resultado\' must be a character string")
  }

  str_extract(resultado, '(?<=com valor negociado a R.{1,4} )(\\d{1,3}\\.)*\\d{1,3},\\d{4}?(?=[^0-9,\\.])') %>%
    str_remove_all('\\s|\\.') %>%
    str_replace(pattern = ',(?=\\d+$)', replacement = '\\.') %>%
    as.numeric()

}
