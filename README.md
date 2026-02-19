# Mapping GBIF Occurrence Records with ggplot2 (Dendrobates example)

This repository contains an R script to visualize species occurrence records from GBIF on a geographic map using `ggplot2` and `rnaturalearth`. The example focuses on poison dart frogs of the genus Dendrobates, whose distribution ranges from Central to South America, but the workflow is general and can be applied to any taxonomic group.

The script uses spatial objects and `geom_sf` to plot occurrence points on top of a world or regional map, making it a simple and reproducible example of how to combine biodiversity data with modern spatial visualization tools in R.

## What this script does

- Retrieves or reads occurrence records from GBIF  
- Filters and prepares geographic coordinates  
- Uses `rnaturalearth` to obtain map layers  
- Plots occurrence points with `ggplot2` using `geom_sf`  
- Produces a clean, presentation-ready map  

## Requirements

- R  
- `ggplot2`  
- `rnaturalearth`  
- `sf`  

## Notes

Although the example uses Dendrobates poison dart frogs, the same workflow can be applied to any species or group with geographic coordinates available from GBIF.  
This script focuses on visualization rather than data cleaning or advanced spatial analysis.
