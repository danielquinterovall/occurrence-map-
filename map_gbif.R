### DQV 18/02/2026###

# R script to map occurrence points of poison dart frogs using GBIF data with ggplot2 and rnaturalearth (geom_sf).

# loading packages

library(tidyverse)
library(data.table)
library(ggthemes)
library(rnaturalearth)

# reading data from GBIF

data <- fread("dendrobatesdata.csv")
str(data)
glimpse(data)

# Keep only columns 3 to 10, 22 and 23, and 31 to 33, as these contain the relevant information for creating the map.

data <- data[,c(3:10, 22, 23, 31:33)]

# Filtering data (we don't want MORE in the longitude, latitude, or year variables)

colnames(data)

data <- data %>%
  filter(!if_any(c(decimalLongitude, decimalLatitude, year), is.na)) %>%
  filter(species != "")

# Delete an extreme piece of data that corresponds to a collection in North America (the natural distribution of Dendrobates is exclusive to Central and South America)

data <- data %>% filter(!decimalLatitude >= 35)

# To verify that there are no unnamed species ("")

unique(data$species) 

# Delete duplicates 

#data[which(duplicated(data$decimalLatitude, data$decimalLongitude)),]

data <- data %>%
  distinct(decimalLongitude, decimalLatitude, species, .keep_all = TRUE)

# Create a map with ggplot2 and rnaturalearte
# ne_countries: Get natural earth world country polygons. 

costa <- rnaturalearth::ne_countries(scale = 110)

# Plotting map with ggplot2

map <- ggplot() + 
  geom_sf(data = costa) +
  geom_point(data = data, 
             aes(x = decimalLongitude, y = decimalLatitude, colour = species)) +
  coord_sf(xlim = c(-120, -30), ylim = c(-20, 30))+
  scale_x_continuous(expand = c(0, 0)) +
  scale_y_continuous(expand = c(0, 0)) +
  labs(x = "Longitude",
       y = "Latitude",
       title = "Where Dendrobates frogs occur") +
  scale_colour_manual(name = NULL,
                      values = c("Dendrobates auratus" = "#26547c",
                                 "Dendrobates truncatus" = "#ef476f",
                                 "Dendrobates tinctorius" = "#ffd166",
                                 "Dendrobates leucomelas" = "#06d6a0"),
                      labels = c("Dendrobates auratus" = "D. auratus",
                                 "Dendrobates truncatus" = "D. truncatus",
                                 "Dendrobates tinctorius" = "D. tinctorius",
                                 "Dendrobates leucomelas" = "D. leucomelas")) +
  theme_bw() +
  theme(legend.position = "bottom",
      axis.title = element_blank())

# Saving map on svg

svg("dendrobates.svg", width = 7, height = 9, bg = "transparent")
map
dev.off()  








