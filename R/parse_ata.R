parse_ata <- function(ata_html_file) {

  html_doc <- read_html(ata_html_file, encoding = 'utf-8')

  df_ata <- tibble(file = ata_html_file) %>%
    bind_cols(get_bid_data(html_doc))

  df_ata

}
