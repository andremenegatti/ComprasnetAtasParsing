parseSeq <- function() {

  # Dataframe que recebera os dados
  df_dados <- tibble()

  # Iteracao entre atas (arquivos)
  for (p in 1:length(atas_files)) {

    # Lendo do arquivo html
    html_doc <- read_html(atas_files[p], encoding = 'utf-8')

    # Capturando informacoes gerais do pregao (que nao se referem a itens especificos)
    df_ata <- tibble(file = atas_files[p]) %>%
      bind_cols(get_bid_data(html_doc))

    # Salvando dados da ata atual na ultima linha de df_dados
    df_dados <- bind_rows(df_dados, df_ata)

  } #  -------------- Fim da iteracao entre atas --------------

  df_dados

}
