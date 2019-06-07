#' Captura informacoes relativas a um item especifico da ata
#'
#' Wrapper de get_item_info_dfs e get_item_info_chr, com opcao adicional de extrair data/hora das etapas da fase da lances.
#'
#' @param item_node xml_node do item
#' @param item_info vetor com informacoes a serem capturadas
#'
#' @return Lista com strings e dataframes
#'
#' @export
get_item_info <- function(item_node, item_info = c('indice_item', 'descricao', 'descricao_complementar', 'quantidade',
                                              'valor_estimado', 'unidade_fornecimento', 'tratamento_diferenciado',
                                              'decreto_7174', 'margem_preferencia', 'situacao', 'resultado',
                                              'propostas', 'lances', 'fases')) {

  # Atalho para extrair todas as informacoes (diferente do default!)
  if (identical(item_info, 'all')) {
    item_info <- c(names(xpaths), 'propostas', 'lances', 'lances_desempate_ME_EPP', 'eventos_item', 'fases')
    # Garantindo que 'indice_item' esta em 'item_info' (informacao necessaria para extracao de outros dados)
  } else if (!'indice_item' %in% item_info) item_info <- c('indice_item', item_info)

  # Dados unidimensionais
  info_chr <- item_info[item_info %in% names(xpaths)]
  info_chr_list <- purrr::map(.x = info_chr,
                          ~ get_item_info_chr(item_node, item_info = .x)) %>% purrr::set_names(info_chr)


  # Dados bidimensionais (dataframes)
  info_df <- item_info[item_info %in% c('propostas', 'lances', 'lances_desempate_ME_EPP', 'eventos_item')]
  info_df_list <- purrr::map(.x = info_df,
                            ~ list(get_item_info_df(html_doc = item_node,
                                                id_item = info_chr_list[["indice_item"]],
                                                item_info = .x))) %>% purrr::set_names(info_df)

  # Extraindo data/hora das etapas da fase de lances a partir da tabela 'eventos_item'
  info_fases_list <- list()
  if ('fases' %in% item_info) {
    if ('eventos_item' %in% item_info) {
      df_eventos_item <- info_df_list$eventos_item[[1]]
    } else {
      df_eventos_item <- get_item_info_df(item_node, id_item = info_chr_list[["indice_item"]], item_info = c('eventos_item'))
    }
    info_fases_list$abertura_lances <- (df_eventos_item %>% filter(Evento == 'Aberto'))$Data
    info_fases_list$iminencia_encerramento <- (df_eventos_item %>% filter(str_detect(Evento, 'Imin.{1,3}ncia de Encerramento')))$Data
    info_fases_list$inicio_fase_aleatoria <- (df_eventos_item %>% filter(str_detect(Evento, 'Imin.{1,3}ncia de Encerramento')))[,3] %>%
      str_extract('\\d{2}/\\d{2}/\\d{4} \\d{2}:\\d{2}:\\d{2}')
    info_fases_list$inicio_desempate <- (df_eventos_item %>% filter(str_detect(Evento, 'Aguardando Convoca.{1,7}ME/EPP')))[1, 'Data']
    info_fases_list$item_encerrado <- (df_eventos_item %>% filter(Evento == 'Encerrado'))[1,'Data']
    info_fases_list$encerramento_lances <- if_else(is.na(info_fases_list$inicio_desempate),
                                                   info_fases_list$item_encerrado,
                                                   info_fases_list$inicio_desempate)
  }

  info_fases_list <- map(.x = info_fases_list, .f = ~ ifelse(length(.x) == 0, NA, .x))

  # Output: concatenacao das tres listas criadas acima
  return(c(info_chr_list, info_fases_list, info_df_list))
}
