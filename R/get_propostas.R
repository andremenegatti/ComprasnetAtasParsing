#' Captura propostas do item
#'
#' Captura as propostas recebidas para o item
#'
#' @param html_doc documento xml referente a ata de um pregao eletronico
#' @param item_id string com o numero do item
#'
#' @return dataframe com dados sobre as propostas
#' @export
#'
#' @examples
get_propostas <- function(html_doc, item_id, quietly = TRUE) {

  if (!quietly) {
    message(str_c(' ---- Capturando propostas do Item ', item_id))
  }

  table_node <- html_node(html_doc,
                          xpath = str_c('//body/table/tbody/tr/td[contains(text(), "Item: ', item_id, ' - ")]/../following-sibling::tr[1]/td/table/tbody/tr/td/b[text()="Propostas"]/ancestor::table[1]'))

  if (length(table_node) == 0) {
    if (!quietly) {
      message(str_c(' ---- Propostas do Item ', item_id, ' nao encontradas'))
    }
    return(NA)
  }

  df_propostas <- html_table(table_node, fill = TRUE) %>%
    select(-X1)

  colnames(df_propostas) <- unlist(df_propostas[2,]) %>%
    str_replace('CNPJ/CPF', 'CNPJ_CPF') %>%
    str_replace('Porte .*', 'porte_ME_EPP') %>%
    str_replace('Declara.* ME.*', 'declaracao_ME_EPP_COOP') %>%
    str_replace("Valor Unit.*", "valor_unitario") %>%
    str_replace("Valor Global", "valor_global") %>%
    str_replace("Data/Hora Registro", "data_hora") %>%
    str_replace("Quantidade", "quantidade") %>%
    str_replace("Fornecedor", "fornecedor")

  df_propostas <- df_propostas %>%
    slice(-c(1,2))

  if (length(unique(df_propostas$CNPJ_CPF)) == nrow(df_propostas) ) {

    return(df_propostas)

  } else if (length(unique(df_propostas$CNPJ_CPF)) == nrow(df_propostas)/2 ) {

    df_fornecedor <- df_propostas %>%
      group_by(CNPJ_CPF) %>%
      slice(-2) %>%
      ungroup()

    df_especificacoes <- df_propostas %>%
      select(CNPJ_CPF, especificacoes = fornecedor) %>%
      group_by(CNPJ_CPF) %>%
      slice(-1) %>%
      ungroup()

    return(left_join(df_fornecedor, df_especificacoes, by = "CNPJ_CPF"))

  } else {

    return(NA)

  }

}
