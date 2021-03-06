% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_segundos.R
\name{get_segundos}
\alias{get_segundos}
\title{Obtem medida de tempo em segundos a partir de uma string com registro de lance}
\usage{
get_segundos(date_string, iso_input = FALSE)
}
\arguments{
\item{date_string}{character string com uma data no formato utilizado nas atas ou em formato ISO-8601}

\item{iso_input}{boolean indicando se o argumento date_string esta em formato ISO-8601 ou nao}
}
\value{
segundos
}
\description{
Funcao util para avaliar intervalo entre lances com precisao.
}
