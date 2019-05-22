#' Captura informacoes do pregao que nao se referem aos itens negociados
#'
#' Funcao utilizada para capturar informacoes do pregao que sao invariantes no que diz respeito aos itens
#'
#' @param html_doc documento xml referente a ata de um pregao eletronico
#' @param eventos se TRUE, eventos do pregao serao capturados
#' @param mensagens se TRUE, mensagens do pregao serao capturadas
#'
#' @return dataframe com as informacoes
#' @seealso Para capturar informacoes referentes a itens de uma ata, ver get_item_info
#' @export
get_bid_info2 <- function(html_doc, info = c('id_pregao', 'data_abertura', 'data_encerramento')) {

  ata_comp <- possui_ata_complementar(html_doc)

  list_ata <- list()

  if ('id_pregao' %in% info) list_ata$id_pregao <- get_id_pregao(html_doc, ata_comp)
  if ('co_uasg' %in% info) list_ata$co_uasg <- get_couasg(html_doc, ata_comp)
  if ('num_preg' %in% info) list_ata$num_preg <- get_numpreg(html_doc, ata_comp)
  if ('possui_ata_complementar' %in% info) list_ata$possui_ata_complementar <- ata_comp
  if ('num_ata' %in% info) list_ata$num_ata <- get_num_ata(html_doc)

  if ('abertura' %in% info) list_ata$abertura <- get_abertura(html_doc, ata_comp)
  if ('encerramento' %in% info) list_ata$encerramento <- get_encerramento(html_doc)

  if ('data_abertura' %in% info && 'abertura' %in% info) list_ata$data_abertura <- get_data(list_ata$abertura) else if ('data_abertura' %in% info) list_ata$data_abertura <- get_data(get_abertura(html_doc, ata_comp))
  if ('data_encerramento' %in% info && 'encerramento' %in% info) list_ata$data_encerramento <- get_data(encerramento) else if ('data_encerramento' %in% info) list_ata$data_encerramento <- get_data(get_encerramento(html_doc))

  df_ata <- bind_cols(list_ata)

  if ('eventos' %in% info) df_ata$eventos <- list(get_bid_events(html_doc))
  if ('mensagens' %in% info) df_ata$mensagens <- list(get_bid_messages(html_doc))

  df_ata

}
