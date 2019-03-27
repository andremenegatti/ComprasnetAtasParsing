get_bid_info_old <- function(html_doc, eventos = FALSE, mensagens = FALSE) {

  xpath_base <- if_else(possui_ata_complementar(html_doc), '/html/body/table[3]', '/html/body/table[2]')

  if (eventos == FALSE & mensagens == FALSE) {
    tibble(id_pregao = get_id_pregao(html_doc, xpath_base),
           possui_ata_complementar = possui_ata_complementar(html_doc),
           num_ata = get_num_ata(html_doc) ,
           cabecalho = get_cabecalho(html_doc, xpath_base),
           encerramento = get_encerramento(html_doc),
           data_abertura = get_data(cabecalho),
           data_encerramento = get_data(encerramento)) %>%
      return()

  } else if (eventos == TRUE & mensagens == FALSE) {
    tibble(id_pregao = get_id_pregao(html_doc, xpath_base),
           possui_ata_complementar = possui_ata_complementar(html_doc),
           num_ata = get_num_ata(html_doc) ,
           cabecalho = get_cabecalho(html_doc, xpath_base),
           encerramento = get_encerramento(html_doc),
           eventos = list(get_bid_events(html_doc))) %>%
      return()

  } else if (eventos == FALSE & mensagens == TRUE) {
    tibble(id_pregao = get_id_pregao(html_doc, xpath_base),
           possui_ata_complementar = possui_ata_complementar(html_doc),
           num_ata = get_num_ata(html_doc) ,
           cabecalho = get_cabecalho(html_doc, xpath_base),
           encerramento = get_encerramento(html_doc),
           mensagens = list(get_bid_messages(html_doc))) %>%
      return()

  } else {
    tibble(id_pregao = get_id_pregao(html_doc, xpath_base),
           possui_ata_complementar = possui_ata_complementar(html_doc),
           num_ata = get_num_ata(html_doc) ,
           cabecalho = get_cabecalho(html_doc, xpath_base),
           encerramento = get_encerramento(html_doc),
           eventos = list(get_bid_events(html_doc)),
           mensagens = list(get_bid_messages(html_doc)))
  }

}
