#' Creates an LGBT Pride Flag with R Logo
#'
#' @param flag character vector with names of the flags
#' @param width numeric (width of the flag)
#' @export
make_banner <- function(flag, width = 1000){

  # tweakable settings
  height <- .6 * width       # fix aspect ratio at .6
  logo_width <- height/2     # logo size fixed at half the height
  gutter <- 0.02 * width     # margin for the edge of overlaid image/text
  font_size <- 0.03 * width  # font size in pixels

  # file paths
  flag_path <- system.file("extdata", paste0(flag, ".svg"), package = "rainbowr")
  logo_path <- system.file("extdata", "r_logo_bw.svg", package = "rainbowr")

  # construct constituents
  flag_img <- magick::image_read_svg(path = flag_path, width = width, height = height)
  logo_img <- magick::image_read_svg(path = logo_path, width = logo_width)
  faux_cmd <- paste0("rainbowR %>% filter(flag = '", flag, "')")

  # place the logo over the flag
  banner <- magick::image_composite(
    image = flag_img,
    composite_image = logo_img,
    operator = "atop",
    offset = paste0("+", (width - logo_width - gutter), "+", logo_width)
  )

  # place the text annotation next
  banner <-magick::image_annotate(
    image = banner,
    text = faux_cmd,
    size = font_size,
    font = "monaco",
    boxcolor = scales::alpha(colour = "white", alpha = .5),
    color = "black",
    gravity = "southeast",
    location = paste0("+", gutter, "+", gutter)
  )

  return(banner)
}

#' Lists the flags
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
