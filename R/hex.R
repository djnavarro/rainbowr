#' Creates an LGBT Pride Hex Sticker with R Logo
#'
#' @param flag character string (e.g., rainbow) naming the flag to be drawn
#' @param width numeric (width of the flag in pixels)
#' @param palette character vector of colours 1, 2 or 4 colours
#' @param background character string specifying the background colour (default = "white")
#' @return An object of class "magick-image"
#' @export
make_hex <- function(flag = "rainbow", width = 1000,
                     palette = c("#cbced0", "#84838b", "#505050", "#a0a0a0"),
                     background = "white") {

  # set up
  opt <- list(
    flag_width = width / .6,
    flag_height = width,
    logo_width = width / 2
  )

  # get the images
  img <- get_images(flag, opt, palette)

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
  hex <- as_hex(hex, background)

  return(hex)
}

as_hex <- function(image, background = "white") {

  height <- magick::image_info(image)$height
  trim_corner <- paste0("0x", round(height*.25))
  trim_edge <- paste0(round(height*.067), "x0")

  # set the background colour
  image <- magick::image_background(image, color = background, flatten = FALSE)

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

#' Creates a Tiling of LGBT Hex Stickers
#'
#' @param  data data frame or tibble specifying the tiling
#' @param  width width of each hex tile in pixels
#' @export
make_hextile <- function(data, width = 1000) {

  hexes <- list()
  ncol <- max(data$col)
  nrow <- max(data$row)
  height <- width / .87
  hextile <- magick::image_blank(width = width * ncol + width,
                                 height = width + width * (.5 + nrow * .5))
  for(i in 1:nrow(data)) {
    message("adding ", data$flag[i], " hex (", i, " of ", nrow(data), ")")
    hexes[[i]] <- make_hex(flag = data$flag[i],
                           palette = c(data$palette1[i], data$palette2[i]),
                           width = width,
                           background = "#123456")

    hexes[[i]] <- magick::image_transparent(hexes[[i]], color = "#123456")
    hexes[[i]] <- magick::image_resize(hexes[[i]], magick::geometry_size_pixels(width, height))

    xpos <- (data$col[i] - 1) * width
    if(data$row[i] %% 2 == 0) xpos <- xpos + width/2
    ypos <- (data$row[i] - 1) * height * .75

    offstr <- paste0("+", xpos, "+", ypos)
    hextile <- magick::image_composite(
      image = hextile,
      composite_image = hexes[[i]],
      operator = "over",
      offset = offstr)
  }


  return(hextile)

}

