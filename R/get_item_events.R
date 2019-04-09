#' Captura o registro de eventos especificos ao item
#'
#' @param html_doc documento xml referente a ata de um pregao eletronico
#' @param item_id string com o numero do item
#'
#' @return dataframe com o registro de eventos do item
#'
#' @export
get_item_events <- function(html_doc, item_id) {

  table_node <- html_node(html_doc,
                          xpath = str_c('//body/table/tbody/tr/td[contains(text(), "Item: ', item_id, ' - ")]/../following-sibling::tr[4]/td/table/tbody/tr/td[contains(text(), "Eventos do")]/ancestor::table[1]'))


  if (length(table_node) == 0) {
    table_node <- html_node(html_doc, xpath = str_c('//body/table/tbody/tr/td[contains(text(), "Item: ', item_id, ' - ")]/../following-sibling::tr[5]/td/table/tbody/tr/td[contains(text(), "Eventos do")]/ancestor::table[1]'))
    if (length(table_node) == 0) {
      return(NA)
    }
  }


  df <- html_table(table_node, fill = TRUE)

  colnames(df) <- unlist(df[2,])

  df %>%
    slice(-c(1,2))

}
