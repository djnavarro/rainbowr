
#' @export
make_hex <- function(flag = "rainbow", width = 1000) {

  opt <- list(
    flag_width = width / .6,
    flag_height = width,
    logo_width = width / 2
  )
  img <- get_images(get_paths(flag), opt)

}
