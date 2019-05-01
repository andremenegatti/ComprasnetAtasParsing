#' Captura registro de lances de desempate de microempresa ou empresa de pequeno porte
#'
#' @param html_doc documento xml referente a ata de um pregao eletronico
#' @param indice_item string com o numero do item
#'
#' @return dataframe com os lances de desempate ou string 'Sem lances de desempate'. Na maior parte dos pregoes, nao ha lances de desempate
#' @export
get_lances_desempate_ME_EPP <- function(html_doc, indice_item) {

  table_node <- html_node(html_doc,
                                    xpath = str_c('//body/table/tbody/tr/td[contains(text(), "Item: ', indice_item, ' - ")]/../following-sibling::tr[3]/td/table/tbody/tr/td[contains(text(), "esempate")]/ancestor::table[1]'))

  if (length(table_node) == 0) {
    return(NA)
  }

  if (str_detect(html_text(table_node), 'N.+o existem lances de desempate')) {
    return('Sem lances de desempate')
  }

  df_lances <- html_table(table_node, fill = TRUE)

  colnames(df_lances) <- unlist(df_lances[2,])

  df_lances %>%
    slice(-c(1,2))

}
