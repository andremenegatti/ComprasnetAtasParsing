get_item_info_chr <- function(item_node, item_info) {

  if (!item_info %in% names(xpaths)) {
    stop("\'item_info\' parameter must be one of the following: (i) item_id; (ii) descricao; (iii) descricao_complementar;
         (iv) quantidade; (v) valor_estimado; (vi) unidade_fornecimento; (viii) tratamento_diferenciado; (ix) decreto_7174;
         (x) margem_preferencia; or (xi) situacao.")
  }

  rvest::html_node(item_node, xpath = xpaths[[item_info]]) %>%
    rvest::html_text() %>%
    stringr::str_remove_all(char_remove[[item_info]])

}
