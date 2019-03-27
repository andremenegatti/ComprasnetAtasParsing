library(dplyr)
library(purrr)
library(rvest)
library(stringr)
library(lubridate)

#### INICIALIZACAO ####

# Definindo variavel com o diretorio onde as atas estao salvas
atas_folder <-  'atas_sample'

# Criando vetores os nomes dos arquivos
atas_files <- list.files(atas_folder)

# Restringindo scraping a atas principais
atas_files = atas_files[str_detect(atas_files, '_ata000\\.html')]

# Dataframe que recebera os dados
df_dados <- tibble()


#### INICIANDO PARSING ####

# Iteracao entre atas (arquivos)
for (p in 1:length(atas_files)) {

  # Exibindo mensagem para acompanhar o progresso
  message(str_c('\n ---- Processando ata n. ', p, '/', length(atas_files), ' ----\n', atas_files[p]))

  # Lendo do arquivo html
  html_doc <- read_html(str_c(atas_folder, '/', atas_files[p]), encoding = 'utf-8')

  # Capturando informacoes gerais do pregao (que nao se referem a itens especificos)
  df_ata <- tibble(file = atas_files[p]) %>%
    bind_cols(get_bid_data(html_doc))

  # Salvando dados da ata atual na ultima linha de df_dados
  df_dados <- bind_rows(df_dados, df_ata)

} #  -------------- Fim da iteracao entre atas --------------


#saveRDS(df_dados, 'df_dados_atas.rds')
