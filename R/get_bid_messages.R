#' Captura as mensagens registradas na ata do pregao
#'
#' @param html_doc documento xml referente a ata de um pregao eletronico
#'
#' @return dataframe com registro das trocas de mensagens
#'
#' @export
get_bid_messages <- function(html_doc) {

  table <- html_node(html_doc,
            xpath = '/html/body/table[last()-2]/tbody//td[contains(text(), "Troca de Mensagens")]/ancestor::table[1]') %>%
    html_table()

  if (table[2,1] == '') {
    table[2,1] <- 'Remetente'
  }

  colnames(table) <- table[2,] %>% unlist()

  table %>%
    slice(-c(1,2))


}
