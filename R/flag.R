#' Creates an LGBT Pride Flag with R Logo
#'
#' @param flag character string (e.g., rainbow) naming the flag to be drawn
#' @param width numeric (width of the flag in pixels)
#' @return An object of class "magick-image"
#' @export
make_banner <- function(flag = "rainbow", width = 1000){

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
  img <- get_images(get_paths(flag), opt)
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

#' List of LGBT Flags
#' @return A character vector
#' @export
list_flags <- function() {
  c(
    "agender",
    "aromantic",
    "asexual",
    "bear",
    "bisexual",
    "demisexual",
    "genderfluid",
    "genderqueer",
    "intersex",
    "lesbian",
    "lipstick_lesbian",
    "nonbinary",
    "pansexual",
    "polyamory",
    "polysexual",
    "rainbow",
    "transgender",
    "twink"
  )
}


get_paths <- function(flag) {
  return(list(
    flag = system.file("extdata", paste0(flag, ".svg"), package = "rainbowr"),
    logo = system.file("extdata", "r_logo_bw.svg", package = "rainbowr")
  ))
}

get_images <- function(path, opt) {
  return(list(
    flag = magick::image_read_svg(path = path$flag,
                                  width = opt$flag_width,
                                  height = opt$flag_height),
    logo = magick::image_read_svg(path = path$logo,
                                  width = opt$logo_width)
  ))
}


# flags <- list.files(path = here("flags"))
#
# for(flag in flags) {
#   banner_name <- flag %>%
#     str_replace(fixed(".svg"), fixed(".png"))
#
#   flag %>%
#     make_banner() %>%
#     image_write(path = here("banners",banner_name))
# }
