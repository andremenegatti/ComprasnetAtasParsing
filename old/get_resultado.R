get_resultado <- function(result_node) {
  if (length(result_node) == 0) {
    return(NA)
  } else if (!str_detect(html_text(result_node), 'Aceito para:')) {
    return(NA)
  } else {
    result_text <- str_remove_all(html_text(result_node), '\\n|\\t|\\r')
    return(result_text)
  }
}
