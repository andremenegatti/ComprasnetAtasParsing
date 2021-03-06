% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_desconto_negociado.R
\name{get_desconto_negociado}
\alias{get_desconto_negociado}
\title{Extrai dado de desconto negociado (em porcentagem) a partir do texto do campo 'resultado'}
\usage{
get_desconto_negociado(resultado)
}
\arguments{
\item{resultado}{character string com o resultado de um item, tal como disponivel no comeco das atas}
}
\value{
numeric
}
\description{
Extrai dado de desconto negociado (em porcentagem) a partir do texto do campo 'resultado'
}
\seealso{
para capturar texto de resultado a partir do html, ver get_item_info e get_item_info_chr
}
