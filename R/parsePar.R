#' Parsing do html das atas usando computacao em paralelo
#'
#' Funcao para extrair dados de um conjunto de atas (em formato html) usando computacao em paralelo para maior velocidade.
#'
#' @param atas_files vetor com os caminhos dos arquivos html das atas
#' @param nworkers numero de workers (nucleos) entre os quais o parsing das atas sera dividido; recomenda-se que seja no maximo igual ao numero de nucleos fisicos
#'
#' @return dataframe com os dados das atas
#' @export
parsePar <- function(atas_files, nworkers) {

  doParallel::registerDoParallel(cores = nworkers)

  df_dados <- foreach::foreach(ata = atas_files,
                               .combine = bind_rows,
                               .export = c("atas_files", "parse_ata"),
                               .packages = c("ComprasnetAtasParsing")) %dopar%
    parse_ata(ata_html_file = ata)

  df_dados

}
