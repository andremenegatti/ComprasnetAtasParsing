get_item_info_gerais <- function(item_node, info = c('item_id', 'descricao', 'descricao_complementar', 'quantidade',
                                                  'valor_estimado', 'unidade_fornecimento', 'tratamento_diferenciado',
                                                  'decreto_7174', 'margem_preferencia', 'situacao', 'resultado')) {

  if (!info %in% names(xpaths)) {
    stop("\'info\' parameter must be one of the following: item_id \n    \n   descricao \n   descricao_complementar \n   quantidade \n   valor_estimado \n   unidade_fornecimento \n   tratamento_diferenciado \n   decreto_7174 \n   margem_preferencia \n   situacao")
  }

  rvest::html_node(item_node, xpath = xpaths[[info]]) %>%
    rvest::html_text() %>%
    stringr::str_remove_all(char_remove[[info]])

}
