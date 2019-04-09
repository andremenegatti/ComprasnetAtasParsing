#' Captura informacoes relativas a um item especifico da ata
#'
#' Wrapper de get_item_info_dfs e get_item_info_chr
#'
#' @param item_node xml_node do item
#' @param item_info vetor com informacoes a serem capturadas
#'
#' @return Lista com strings e dataframes
#'
#' @export
get_item_info <- function(item_node, item_info = c('item_id', 'descricao', 'descricao_complementar', 'quantidade',
                                              'valor_estimado', 'unidade_fornecimento', 'tratamento_diferenciado',
                                              'decreto_7174', 'margem_preferencia', 'situacao', 'resultado',
                                              'propostas', 'lances')) {

  if (identical(item_info, 'all')) {
    item_info <- c(names(xpaths), 'propostas', 'lances', 'lances_desempate_ME_EPP', 'eventos_item')
  }

  info_chr <- item_info[item_info %in% names(xpaths)]

  info_df <- item_info[item_info %in% c('propostas', 'lances', 'lances_desempate_ME_EPP', 'eventos_item')]

  info_chr_list <- purrr::map(.x = info_chr,
                          ~ get_item_info_chr(item_node, item_info = .x)) %>%
    purrr::set_names(info_chr)

  info_df_list <- purrr::map(.x = info_df,
                            ~ list(get_item_info_df(html_doc = item_node,
                                                id_item = info_chr_list[["item_id"]],
                                                item_info = .x))) %>%
    purrr::set_names(info_df)

  return(c(info_chr_list, info_df_list))

}
