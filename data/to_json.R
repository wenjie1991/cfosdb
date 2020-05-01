#!/usr/bin/env Rscript 

library(RSQLite)
library(data.table)

d1 = fread("./clean_behavior_brain_area.tsv")
j1 = jsonlite::toJSON(d1, pretty = T)
write(j1, "./clean_behavior_brain_area.json")

d2 = fread("./clean_brain_area_annotation.tsv")
j2 = jsonlite::toJSON(d2, pretty = T)
write(j2, "./clean_brain_area_annotation.json")
