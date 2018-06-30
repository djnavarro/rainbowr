library(tidyverse)
library(magick)
library(rsvg)
library(here)

make_banner <- function(flag, banner_width = 1000){
  
  # tweakable settings
  banner_height <- .6 * banner_width  # fix aspect ratio at .6
  logo_width <- banner_height/2 # logo size fixed at half the height
  gutter <- 0.02 * banner_width # margin for the edge of overlaid image/text
  font_size <- 0.03 * banner_width # font size in pixels
  
  # load images
  flag_img <- image_read_svg(here("flags",flag), width = banner_width, height = banner_height)
  R_img <- image_read_svg(here("Rlogo_bw.svg"), width = logo_width)
  faux_cmd <-  paste0("rainbowR %>% filter(flag = '", str_remove(flag, fixed(".svg")), "')")
  
  # make banner
  banner <- flag_img %>%
    image_composite(
      composite_image = R_img,
      operator = "atop",
      offset = paste0("+", (banner_width - logo_width - gutter), "+", logo_width)
      ) %>%
    image_annotate(
      text = faux_cmd, size = font_size, font = "monaco",
      boxcolor = alpha("white",.5), color = "black",
      gravity = "southeast", location = paste0("+",gutter,"+",gutter)
      ) 
  
  return(banner)
}

flags <- list.files(path = here("flags"))

for(flag in flags) {
  banner_name <- flag %>%
    str_replace(fixed(".svg"), fixed(".png"))

  flag %>% 
    make_banner() %>% 
    image_write(path = here("banners",banner_name))
}

