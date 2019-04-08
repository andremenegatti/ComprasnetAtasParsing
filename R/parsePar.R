parsePar <- function(nworkers) {

  registerDoParallel(cores = nworkers)

  df_dados <- foreach(ata = atas_files,
                      .combine = bind_rows,
                      .export = c("atas_files", "parse_ata"),
                      .packages = c("dplyr", "purrr", "rvest", "stringr", "lubridate", "ComprasnetAtasParsing")) %dopar%
    parse_ata(ata_html_file = ata)

  df_dados

}
