#' Captura os eventos registrados da ata do pregao
#'
#' @param html_doc documento xml referente a ata de um pregao eletronico
#'
#' @return Retorna um dataframe com informacoes sobre os eventos registrados na ata
#' @export
get_bid_events <- function(html_doc) {

  table <- html_node(html_doc,
            xpath = '/html/body/table[last()-2]/tbody//td[contains(text(), "Eventos do Preg")]/ancestor::table[1]') %>%
    html_table()

  colnames(table) <- unlist(table[2,])

  table %>% slice(-c(1,2))

}
