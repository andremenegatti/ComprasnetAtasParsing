#' Extrai valor de melhor lance com desconto
#'
#' @param resultado character string com o resultado de um item, tal como disponivel no comeco das atas
#'
#' @return numeric
#' @seealso para capturar texto de resultado a partir do html, ver get_item_info e get_item_info_chr
#' @export
get_valor_com_desconto <- function(resultado) {

  if (class(resultado) != 'character') {
    stop("\'resultado\' must be a character string")
  }

  str_match(resultado, 'pelo melhor lance de \\d{1,2},?\\d{0,4}? % \\(valor com desconto: R.{1,4} ([0-9,\\.]+)\\)')[,2] %>%
    str_remove_all('\\s|\\.') %>%
    str_replace(pattern = ',(?=\\d+$)', replacement = '\\.') %>%
    as.numeric()

}
