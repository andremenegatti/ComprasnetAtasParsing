get_vencedor <- function(resultado) {

  if (class(resultado) != 'character') {
    stop("\'resultado\' must be a character string")
  }

  str_extract(x, '(?<=Aceito para: ).+?(?=,)')

}
