#' Import dataset from RITA exports. Repair missing values and dates.
#' @param csv file.
#' @return tibble.

import <- function(csv){
  readr::read_csv2(csv) %>%
    dplyr::mutate_at(dplyr::vars(dplyr::starts_with("F")), ~ dplyr::na_if(.x, "01/01/1900")) %>%
    dplyr::mutate_all(~ dplyr::na_if(.x, -999)) %>%
    dplyr::mutate_all(~ dplyr::na_if(.x, 999)) %>%
    dplyr::mutate_all(~ dplyr::na_if(.x, "...")) %>%
    dplyr::mutate_all(~ dplyr::na_if(.x, "Seleccione...")) %>%
    dplyr::mutate_at(dplyr::vars(dplyr::starts_with("F")), lubridate::dmy)
}
