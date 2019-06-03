#' Creates an LGBT Pride Hex Sticker with R Logo
#'
#' @param flag character string (e.g., rainbow) naming the flag to be drawn
#' @param width numeric (width of the flag in pixels)
#' @return An object of class "magick-image"
#' @export
make_hex <- function(flag = "rainbow", width = 1000) {

  opt <- list(
    flag_width = width / .6,
    flag_height = width,
    logo_width = width / 2
  )
  img <- get_images(get_paths(flag), opt)

  # crop the flag to square
  img$flag <- magick::image_crop(
    image = img$flag,
    geometry = magick::geometry_area(width, width))

  # construct the overlay
  hex <- magick::image_composite(
      image = img$flag,
      composite_image = img$logo,
      operator = "atop",
      offset = magick::geometry_point(
        x = width/2 - magick::image_info(img$logo)$width/2,
        y = width/2 - magick::image_info(img$logo)$height/2)
    )

  # truncate to hexagon
  hex <- as_hex(hex)

  return(hex)
}

as_hex <- function(image) {

  height <- magick::image_info(image)$height
  trim_corner <- paste0("0x", round(height*.25))
  trim_edge <- paste0(round(height*.067), "x0")

  # this is really inefficient, but it was the
  # first thing I thought of and I'm too lazy to
  # think of a better way right now...
  image <- magick::image_rotate(image, 30)
  image <- magick::image_chop(image, trim_corner)
  image <- magick::image_rotate(image, -60)
  image <- magick::image_trim(image)
  image <- magick::image_chop(image, trim_corner)
  image <- magick::image_rotate(image, 240)
  image <- magick::image_trim(image)
  image <- magick::image_chop(image, trim_corner)
  image <- magick::image_rotate(image, -60)
  image <- magick::image_trim(image)
  image <- magick::image_chop(image, trim_corner)
  image <- magick::image_rotate(image, 210)
  image <- magick::image_trim(image)
  image <- magick::image_chop(image, trim_edge)
  image <- magick::image_rotate(image, 180)
  image <- magick::image_trim(image)
  image <- magick::image_chop(image, trim_edge)
  image <- magick::image_rotate(image, -180)
  image <- magick::image_trim(image)

  return(image)
}


