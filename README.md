# Rainbow R

- author: Danielle Navarro
- contact: https://twitter.com/djnavarro

Automatically generates LGBT banner images from various LGBT pride flags: relies on the `tidyverse`, `magick`, `rsvg` and `here` packages. Here's the result for the rainbow flag:

![](./banners_small/rainbow.png)

The transgender flag:

![](./banners_small/transgender.png)

Etc.

I chose the set of flags by looking at the Wikipedia page for [LGBT symbols](https://en.wikipedia.org/wiki/LGBT_symbols) and the Wikicommons page for [Sexual identity symbols](https://commons.wikimedia.org/wiki/Sexual_identity_symbols). I'm a little uncomfortable about it though insofar as a lot of them don't pertain to my own identification, so I don't feel confident in making decisions about what should be included and what shouldn't. Roughly what I tried to do was retain anything that appears to be a self-identity category of some kind (e.g., gay, lesbian, transgender, asexual, genderqueer, etc), but not include things that are something more like subcultures (e.g., leather, drag). The lines are super-blurry though. There are pride flags for bear, twink, lipstick lesbian etc that are described on the Wikipedia pages in terms that come closer to being identity categories. I tended to include those, but I admit that I don't feel sure about my choices here! 

Contents of the repository:

- `flags` directory contains the SVG files for the flags
- `Rlogo.svg` is the original R logo; `Rlogo_bw.svg` is a modified version
- `rainbow.R` is the script that draws the banners
- `banners` directory contains the output (1000x600 pixels)
- `banners_small` contains the same images (600x360 pixels)

Most of the banner images come out pretty readable: the nonbinary one is an obvious exception, where we lose half of the R logo. 