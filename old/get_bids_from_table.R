
get_bids_from_table <- function(lances_table_node) {
  
  if (ncol(html_table(lances_table_node, fill = TRUE)) == 6) {
    df_lances <- html_table(lances_table_node, fill = TRUE) %>%
      select(valor_lance = X2, fator_equalizacao = X3, valor_equalizado = X4, cnpj = X5, data_hora = X6) %>% 
      slice(-c(1,2))
  } else if (ncol(html_table(lances_table_node, fill = TRUE)) == 5) {
    df_lances <- html_table(lances_table_node, fill = TRUE) %>%
      select(desconto = X2, valor_com_desconto = X3, cnpj = X4, data_hora = X5) %>% 
      slice(-c(1,2))
  } else {
    df_lances <- html_table(lances_table_node) %>%
      select(valor_lance = X2, cnpj = X3, data_hora = X4) %>% 
      slice(-c(1,2))
  }
  
  return(df_lances)
  
}