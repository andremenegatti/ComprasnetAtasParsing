% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/toISOdate.R
\name{toISOdate}
\alias{toISOdate}
\title{Converte string de data do historico de lances para o formato ISO-8601}
\usage{
toISOdate(date_string, as_character = TRUE)
}
\arguments{
\item{date_string}{uma string de caracteres representando datas no formato
utilizado no historico de lances}

\item{as_character}{boolean que indica que o resultado será em formato de
caracteres ou data}
}
\value{
Se as_character = TRUE, retorna uma string de caracteres com a data
  em formato ISO-8601. Se as_character = FALSE, retorna objeto datetime
}
\description{
Converte string de data do historico de lances para o formato ISO-8601
}
