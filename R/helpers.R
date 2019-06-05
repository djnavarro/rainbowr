
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


get_images <- function(flag, opt, palette) {

  # where are the files?
  flag_path <- system.file("extdata", paste0(flag, ".svg"), package = "rainbowr")
  logo_path <- system.file("extdata", "r_logo_template.svg", package = "rainbowr")

  # check the palette
  if(length(palette) == 1) { palette = rep(palette, 4) }
  if(length(palette) == 2) { palette = c(rep(palette[1], 2), rep(palette[2], 2)) }
  if(length(palette) != 4) stop("`palette` argument must have length 1, 2 or 4")

  # convert colours to format needed by svg
  pal <- grDevices::col2rgb(palette)
  pal <- apply(pal, 2, function(x) { paste0("rgb(", paste0(x, collapse = ", "), ")")})

  # edit the svg template to use appropriate palette
  txt <- readLines(logo_path)
  txt <- gsub("PALETTE1", pal[1], txt)
  txt <- gsub("PALETTE2", pal[2], txt)
  txt <- gsub("PALETTE3", pal[3], txt)
  txt <- gsub("PALETTE4", pal[4], txt)

  # write the modified svg
  logo_new <- paste0(tempfile(), ".svg")
  con <- file(logo_new)
  writeLines(txt, con)
  close(con)

  # read images
  img <- list(
    flag = magick::image_read_svg(path = flag_path,
                                  width = opt$flag_width,
                                  height = opt$flag_height),
    logo = magick::image_read_svg(path = logo_new,
                                  width = opt$logo_width)
  )

  return(img)
}
