#' Extrai dado de quantidade a partir do texto do campo 'resultado'
#'
#' @param resultado character string com o resultado de um item, tal como disponivel no comeco das atas
#'
#' @return character
#' @seealso para capturar texto de resultado a partir do html, ver get_item_info e get_item_info_chr
#' @export
get_quantidade <- function(resultado) {

  if (class(resultado) != 'character') {
    stop("\'resultado\' must be a character string")
  }

  str_extract(resultado, '(?<= quantidade de ).+')

}
