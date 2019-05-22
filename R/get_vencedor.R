#' Extrai o nome do vencedor do pregao a partir do texto do campo 'resultado'
#'
#' @param resultado character string com o resultado de um item, tal como disponivel no comeco das atas
#'
#' @return character string com o nome do vencedor
#' @export
#'
get_vencedor <- function(resultado) {

  if (class(resultado) != 'character') {
    stop("\'resultado\' must be a character string")
  }

  str_extract(resultado, '(?<=Aceito para: ).+?(?=,)')

}
