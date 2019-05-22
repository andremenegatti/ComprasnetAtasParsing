#' Extrai dado de melhor lance (desconto, em porcentagem) a partir do texto do campo 'resultado'
#'
#' @param resultado character string com o resultado de um item, tal como disponivel no comeco das atas
#'
#' @return numeric
#' @seealso para capturar texto de resultado a partir do html, ver get_item_info e get_item_info_chr
#' @export
get_desconto <- function(resultado) {

  if (class(resultado) != 'character') {
    stop("\'resultado\' must be a character string")
  }

  str_match(resultado, 'pelo melhor lance de (\\d{1,2},?\\d{1,4}?)\\s?%')[,2] %>%
    str_replace(pattern = ',', replacement = '\\.') %>%
    as.numeric()

}
