#' Captura historico de lances do item e limpa os dados
#'
#' Captura o historico de lances do item, com a opcao de limpar os dados automaticamente. Funcao em desenvolvimento.
#'
#'
#' @param html_doc documento xml referente a ata de um pregao eletronico
#' @param item_id string com o numero do item
#' @param clean boolean
#'
#' @return dataframe com o historico de lances, contendo cnpj do fornecedor, valor do lance e horario em que o lance foi registrado. Em alguns casos, o dataframe tambem contem informacoes adicionais como desconto, valor com desconto, fator de equalizacao e/ou valor equalizado
#' @export
get_lances_clean <- function(html_doc, item_id, clean = TRUE) {

  message(str_c(' ---- Capturando lances do Item ', item_id))

  table_node <- html_node(html_doc,
                          xpath = str_c('//body/table/tbody/tr/td[contains(text(), "Item: ', item_id, ' - ")]/../following-sibling::tr[2]/td/table/tbody/tr/td/b[text()="Lances "]/ancestor::table[1]'))

  if (length(table_node) == 0) {
    message(str_c(' ---- Historico de lances do Item ', item_id, ' nao encontrado'))
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

  if (!clean) {
    return(df_lances %>% slice(-c(1,2)))
  } else {

    df_lances %>%
      slice(-c(1,2)) %>%
      mutate_at(vars(matches('valor')), limpar_valores) %>%
      mutate(data_hora = toISOdate(data_hora, as_character = TRUE))

  }

}
