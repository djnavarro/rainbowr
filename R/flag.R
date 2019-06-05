#' Creates an LGBT Pride Flag with R Logo
#'
#' @param flag character string (e.g., rainbow) naming the flag to be drawn
#' @param width numeric (width of the flag in pixels)
#' @param palette character vector of colours 1, 2 or 4 colours
#' @return An object of class "magick-image"
#' @export
make_banner <- function(flag = "rainbow", width = 1000,
                        palette = c("#cbced0", "#84838b", "#505050", "#a0a0a0")){

  # settings
  opt <- list(
    flag_width = width,
    flag_height = .6 * width,
    logo_width = .3 * width,
    gutter = .02 * width,
    font_size = .03 * width
  )
  opt$left <- opt$flag_width - opt$logo_width - opt$gutter

  # construct constituents
  img <- get_images(flag, opt, palette)
  cmd <- paste0("rainbowR %>% filter(flag = '", flag, "')")

  # place the logo over the flag
  banner <- magick::image_composite(
    image = img$flag,
    composite_image = img$logo,
    operator = "atop",
    offset = paste0("+", opt$left, "+", opt$logo_width)
  )

  # place the text annotation next
  banner <-magick::image_annotate(
    image = banner,
    text = cmd,
    size = opt$font_size,
    font = "monaco",
    boxcolor = scales::alpha(colour = "white", alpha = .5),
    color = "black",
    gravity = "southeast",
    location = paste0("+", opt$gutter, "+", opt$gutter)
  )

  return(banner)
}



