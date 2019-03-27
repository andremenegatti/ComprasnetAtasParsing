#### INICIALIZACAO ####
library(tidyverse)
library(httr)
library(rvest)

source("COMPRASNET_parsing_atas_fp_helpers.r")

# Definindo variavel com o diretorio onde as atas estao salvas
atas_folder <-  'C:/Users/Dell/Desktop/atas_papel'

# Criando vetores com subconjuntos de atas de interesse
atas_files <- list.files(atas_folder)

# Dataframe que recebera os dados
df_dados <- tibble()

# Definicoes alternativas do conjunto de atas para teste
atas_files = atas_files[str_detect(atas_files, '_ata000\\.html')]
atas_files = atas_files[1:10]
# atas_files = c('9966120000122017_ata000.html', '9860010005672014_ata001.html',
#                '9860010005672014_ata001.html', '0200010000152017_ata000.html', '0800260000062011_ata000.html')

#### INICIANDO PARSING ####

# Iteracao entre atas (arquivos)
for (p in 1:length(atas_files)) {

  ata = atas_files[p]

  # Exibindo mensagens para acompanhar o progresso
  message(str_c('\n ---- Processando ata n. ', p, '/', length(atas_files), ' ----'))
  message(ata)

  # Lendo do arquivo html
  html_doc <- read_html(str_c(atas_folder, '/', ata), encoding = 'utf-8')

  df_ata <- possibly(get_bid_data, 'error')(html_doc, xpaths, char_remove)

  df_dados <- bind_rows(df_dados, df_ata)

} #  -------------- Fim da iteracao entre atas --------------
