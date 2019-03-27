#### INICIALIZACAO ####
library(dplyr)
library(purrr)
library(rvest)
library(stringr)

# Definindo variavel com o diretorio onde as atas estao salvas
atas_folder <-  'C:/Users/Dell/Desktop/atas_papel'

# Criando vetores com subconjuntos de atas de interesse
atas_files <- list.files(atas_folder)

# Dataframe que recebera os dados
df_dados <- tibble()

# Definicoes alternativas do conjunto de atas para teste
atas_files = atas_files[str_detect(atas_files, '_ata000\\.html')]
#atas_files = atas_files[1:10]
# atas_files = c('9966120000122017_ata000.html', '9860010005672014_ata001.html',
#                '9860010005672014_ata001.html', '0200010000152017_ata000.html', '0800260000062011_ata000.html')

#### INICIANDO PARSING ####

# Iteracao entre atas (arquivos)
for (p in 1242:length(atas_files)) {

  ata = atas_files[p]

  # Exibindo mensagens para acompanhar o progresso
  message(str_c('\n ---- Processando ata n. ', p, '/', length(atas_files), ' ----'))
  message(ata)

  # Lendo do arquivo html
  html_doc <- read_html(str_c(atas_folder, '/', ata), encoding = 'utf-8')

  # Lidando com diferencas no codigo html conforme existam ou nao atas complementares
  xpath_base <- if_else(possui_ata_complementar(html_doc), '/html/body/table[3]', '/html/body/table[2]')

  df_ata <- tibble(file = ata,
                   id_pregao = get_id_pregao(html_doc, xpath_base),
                   possui_ata_complementar = possui_ata_complementar(html_doc),
                   num_ata = get_num_ata(html_doc) ,
                   abertura = get_abertura(html_doc, xpath_base),
                   encerramento = get_encerramento(html_doc) #,
                   #eventos = list(get_bid_events(html_doc)),
                   #mensagens = list(get_bid_messages(html_doc))
                   )

  id_item_nodes <- get_item_nodes(html_doc, xpath_base = xpath_base)

  df_info <- map_df(id_item_nodes, ~ possibly(get_all_item_info, 'error')(item_node = .x))

  message('-- Salvando resultados...')

  df_ata$dados <- list(df_info)

  df_dados <- bind_rows(df_dados, df_ata)

} #  -------------- Fim da iteracao entre atas --------------


#saveRDS(df_dados, 'df_dados_atas.rds')
