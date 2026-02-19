### EJERCICIO DENDROBATES ###

# loading packages

library(tidyverse)
library(data.table)

# reading data

data <- fread("./data/dendrobatesdata.csv")
str(data)
glimpse(data)

# Solo las columnas de la 3 a a 10, la 22 y la 23 y la 31 a la 33

data <- data[,c(3:10, 22, 23, 31:33)]

# Filtrando datos (no NA's en longitud, latitud o ano)

colnames(data)

data <- data %>%
  filter(!if_any(c(decimalLongitude, decimalLatitude, year), is.na)) %>%
  filter(species != "")

# Borrar un dato extremo 

data <- data %>% filter(!decimalLatitude >= 35)

# corroborar que no hay especies sin nombre o diferentes

unique(data$species) 

# Pseudomapa

plot(x = data$decimalLongitude, 
     y = data$decimalLatitude, 
     col = factor(data$species),
     xlab = "Longitude",
     ylab = "Latitude",
     main = "Dendrobates occurrences")

# Eliminar duplicados

#data[which(duplicated(data$decimalLatitude, data$decimalLongitude)),]

data <- data %>%
  distinct(decimalLongitude, decimalLatitude, species, .keep_all = TRUE)

# Mapa con ggplot

library(ggthemes)
library(rnaturalearth)

data %>% ggplot(aes(x = decimalLongitude, y = decimalLatitude, colour = species)) +
  geom_point() +
  labs(x = "Longitud",
       y = "Latitud",
       title = "Dendrobates occurrences") +
  scale_colour_manual(name = "Especies",
                      values = c("Dendrobates auratus" = "#26547c",
                                 "Dendrobates truncatus" = "#ef476f",
                                 "Dendrobates tinctorius" = "#ffd166",
                                 "Dendrobates leucomelas" = "#06d6a0"),
                      labels = c("Dendrobates auratus" = "D. auratus",
                                 "Dendrobates truncatus" = "D. truncatus",
                                 "Dendrobates tinctorius" = "D. tinctorius",
                                 "Dendrobates leucomelas" = "D. leucomelas")) +
  theme_bw()

# Usando rnaturalearth

costa <- rnaturalearth::ne_countries(scale = 110)

svg("./fig/dendrobates.svg", width = 7, height = 9, bg = "transparent")

ggplot() + 
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

dev.off()  








