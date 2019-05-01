#' Captura historico de lances do item
#'
#' Captura o historico de lances do item
#'
#' @param html_doc documento xml referente a ata de um pregao eletronico
#' @param indice_item string com o numero do item
#'
#' @return dataframe com o historico de lances, contendo cnpj do fornecedor, valor do lance e horario em que o lance foi registrado. Em alguns casos, o dataframe tambem contem informacoes adicionais como desconto, valor com desconto, fator de equalizacao e/ou valor equalizado
#' @export
get_lances <- function(html_doc, indice_item, quietly = TRUE) {

  if (!quietly) {
    message(str_c(' ---- Capturando lances do Item ', indice_item))
  }

  table_node <- html_node(html_doc,
                          xpath = str_c('//body/table/tbody/tr/td[contains(text(), "Item: ', indice_item, ' - ")]/../following-sibling::tr[2]/td/table/tbody/tr/td/b[text()="Lances "]/ancestor::table[1]'))

  if (length(table_node) == 0) {
    if (!quietly) {
      message(str_c(' ---- Historico de lances do Item ', indice_item, ' nao encontrado'))
    }
    return(NA)
  }

  df_lances <- html_table(table_node, fill = TRUE) %>%
    select(-X1)

  colnames(df_lances) <- unlist(df_lances[2,]) %>%
    str_replace('CNPJ/CPF', 'CNPJ_CPF') %>%
    str_replace("Data/Hora Registro", "data_hora") %>%
    str_replace('Valor do Lance$', 'valor_lance') %>%
    str_replace('Fator de Equal.*', 'fator_equalizacao') %>%
    str_replace('.* Equalizado', 'valor_equalizado') %>%
    str_replace('^Desconto', 'desconto') %>%
    str_replace('Valor .* Desconto', 'valor_com_desconto')

  return(df_lances %>% slice(-c(1,2)))

}
