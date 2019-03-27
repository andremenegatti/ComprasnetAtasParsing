get_item_info_old <- function(item_node, xpath_root = NA, xpaths = NA, char_remove = NA) {

  if (is.na(xpath_root)) {
    xpath_base <- if_else(possui_ata_complementar(item_node), '/html/body/table[3]', '/html/body/table[2]')
  }

  if (is.na(xpaths)[1]) {
    xpaths <- xpaths()
  }

  if (is.na(char_remove)[1]) {
    char_remove <- char_remove()
  }

  # Extraindo numero do item
  info_item <- list(item_id = html_text(item_node) %>% str_remove_all("Item: |\\r|\\n"))

  for (i in names(xpaths)) {
    info_node <- html_node(item_node, xpath = xpaths[[i]])
    info_text <- html_text(info_node)
    info_text_clean <- str_remove_all(info_text, char_remove[[i]])
    info_item[[i]] <- info_text_clean
  }

  message(str_c('-- Capturando dados do Item ', info_item[["item_id"]]))

  # Extraindo resultado
  result_node <- html_node(item_node,
                             xpath = 'ancestor::tbody[1]//*[contains(text()," Complementar: ")]/../ancestor::table[2]/following-sibling::table[1]')

  info_item[["resultado"]] <- get_result(result_node)


  # Extraindo historico de lances
  info_item[["lances"]] <- list(get_lances(item_node, item_id = info_item[["item_id"]]))

  # Extraindo propostas
  info_item[["propostas"]] <- list(get_propostas(item_node, item_id = info_item[["item_id"]]))

  # Extraindo lances desempate
  #info_item[['lances_desempate_ME_EPP']] <-  list(get_desempate(item_node, item_id = info_item[["item_id"]]))

  # Extraindo eventos do item
  #info_item[['eventos_item']] <- list(get_item_events(item_node, item_id = info_item[["item_id"]]))

  return(info_item)

}
