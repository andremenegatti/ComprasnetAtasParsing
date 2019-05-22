#' Extrai diversas informacoes disponiveis no campo 'resultado'
#'
#' @param resultado character string com o resultado de um item, tal como disponivel no comeco das atas
#' @param info vetor com as informacoes desejadas
#'
#' @return Caso apenas uma informacao seja incluida em 'info', a funcao retorna um vetor numerico ou de caracteres . Caso mais informacoes sejam solicitadas, a funcao retorna um dataframe.
#' @export
#'
#' @examples
parse_resultado <- function(resultado, info = c('vencedor', 'melhor_lance', 'valor_negociado', 'quantidade', 'desconto',
                                                'desconto_negociado', 'valor_com_desconto', 'valor_com_desconto_negociado')) {

  list_info <- list()
  if ('vencedor' %in% info) list_info['vencedor'] <- get_vencedor(resultado) %>% list()
  if ('melhor_lance' %in% info) list_info['melhor_lance'] <- get_melhor_lance(resultado) %>% list()
  if ('valor_negociado' %in% info) list_info['valor_negociado'] <- get_valor_negociado(resultado) %>% list()
  if ('quantidade' %in% info) list_info['quantidade_resultado'] <- get_quantidade(resultado) %>% list()
  if ('desconto' %in% info) list_info['desconto'] <- get_desconto(resultado) %>% list()
  if ('desconto_negociado' %in% info) list_info['desconto_negociado'] <- get_desconto_negociado(resultado) %>% list()
  if ('valor_com_desconto' %in% info) list_info['valor_com_desconto'] <- get_valor_com_desconto(resultado) %>% list()
  if ('valor_com_desconto_negociado' %in% info) list_info['valor_com_desconto_negociado'] <- get_valor_com_desconto_negociado(resultado) %>% list()

  if (length(info) == 1) return(list_info[[1]]) else bind_cols(list_info)

}
