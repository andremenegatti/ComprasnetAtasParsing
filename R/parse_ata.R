#' Funcao para extrair dados do codigo html de uma ata
#'
#' O principal uso desta funcao se da no contexto das funcoes parsePar e parseSeq, que capturam dados de varias atas de forma automatizada
#'
#' @param ata_html_file caminho do arquivo html da ata cujas informacoes serao extraidas
#'
#' @return dataframe com os dados da ata
#' @export
parse_ata <- function(ata_html_file) {

  html_doc <- read_html(ata_html_file, encoding = 'utf-8')

  df_ata <- tibble(file = ata_html_file) %>%
    bind_cols(get_bid_data(html_doc))

  df_ata

}
