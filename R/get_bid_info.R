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
get_bid_info <- function(html_doc, eventos = FALSE, mensagens = FALSE) {

  ata_comp <- possui_ata_complementar(html_doc)

  df_ata <- tibble(id_pregao = get_id_pregao(html_doc, ata_comp),
                   co_uasg = get_couasg(html_doc, ata_comp),
                   num_preg = get_numpreg(html_doc, ata_comp),
                   possui_ata_complementar = ata_comp,
                   num_ata = get_num_ata(html_doc) ,
                   abertura = get_abertura(html_doc, ata_comp),
                   encerramento = get_encerramento(html_doc),
                   data_abertura = get_data(abertura),
                   data_encerramento = get_data(encerramento))

  if (eventos) {
    df_ata$eventos <- get_bid_events(html_doc)
  }

  if (mensagens) {
    df_ata$mensagens <- get_bid_messages(html_doc)
  }

  df_ata

}
