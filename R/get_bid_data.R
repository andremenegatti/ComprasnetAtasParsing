#' Capturar dados do pregao
#'
#' Principal funcao para capturar os dados disponiveis na ata de um pregao eletronico do Comprasnet
#'
#' @param html_doc documento xml referente a ata de um pregao eletronico
#' @param eventos se TRUE, eventos do pregao serao capturados
#' @param mensagens se TRUE, mensagens do pregao serao capturadas
#' @param item_info vetor de strings contendo as informacoes que serao capturadas, podendo incluir: 'indice_id', 'descricao', 'descricao_complementar', 'quantidade', 'valor_estimado', 'unidade_fornecimento', 'tratamento_diferenciado', 'decreto_7174', 'margem_preferencia', 'situacao', 'resultado', 'propostas', 'lances', 'lances_desempate_ME_EPP', e 'eventos_item'
#'
#' @return Retorna um uma tibble, com estrutura de dataframe aninhado. Os dados referentes aos itens do pregao ficam na coluna 'dados', em um novo dataframe. Para cada item desse segundo dataframe, dados como historico de lances e propostas sao incluidos em uma terceira camada de dataframes aninhados.
#' @export
get_bid_data <- function(html_doc,
                         eventos = FALSE,
                         mensagens = FALSE,
                         item_info = c('indice_id', 'descricao', 'descricao_complementar', 'quantidade',
                                       'valor_estimado', 'unidade_fornecimento', 'tratamento_diferenciado',
                                       'decreto_7174', 'margem_preferencia', 'situacao', 'resultado',
                                       'propostas', 'lances')
                         ) {

  df_ata <- get_bid_info(html_doc,
                         eventos = eventos,
                         mensagens = mensagens)

  id_item_nodes <- get_item_nodes(html_doc,
                                  df_ata$possui_ata_complementar)

  df_info <- map_df(.x = id_item_nodes,
                    ~ possibly(get_item_info, 'error')(item_node = .x,
                                                       item_info = item_info))

  df_ata$dados <- list(df_info)

  df_ata

}
