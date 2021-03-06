% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_item_info.R
\name{get_item_info}
\alias{get_item_info}
\title{Captura informacoes relativas a um item especifico da ata}
\usage{
get_item_info(item_node, item_info = c("indice_item", "descricao",
  "descricao_complementar", "quantidade", "valor_estimado",
  "unidade_fornecimento", "tratamento_diferenciado", "decreto_7174",
  "margem_preferencia", "situacao", "resultado", "propostas", "lances",
  "fases"))
}
\arguments{
\item{item_node}{xml_node do item}

\item{item_info}{vetor com informacoes a serem capturadas}
}
\value{
Lista com strings e dataframes
}
\description{
Wrapper de get_item_info_dfs e get_item_info_chr, com opcao adicional de extrair data/hora das etapas da fase da lances.
}
