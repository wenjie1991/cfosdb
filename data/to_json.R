#!/usr/bin/env Rscript 

library(RSQLite)
library(data.table)
library(stringr)
library(stringi)
library(magrittr)
library(plyr)

## behavior brain area table
d1 = fread("./clean_behavior_brain_area.tsv")
d1$behavior %<>% revalue(c("agression" = "aggression", "Sexual behavior" = "mating"))
j1 = jsonlite::toJSON(d1, pretty = T)
write(j1, "./clean_behavior_brain_area.json")

## brain area annotation table
d2 = fread("./clean_brain_area_annotation.tsv")
d2$abbr = d2$long %>% stri_reverse() %>%  str_split_fixed("[()]", 3) %>% extract(, 2) %>% stri_reverse()
j2 = jsonlite::toJSON(d2, pretty = T)
write(j2, "./clean_brain_area_annotation.json")

## behavior overlap
d = fread("./clean_behavior_brain_area.tsv")
d$behavior %<>% revalue(c("agression" = "aggression", "Sexual behavior" = "mating"))

gen_count_table = function(dd) {
    behaviors = dd$behavior %>% unique
    join_count = list()
    for (i in 1:(length(behaviors) - 1)) {
        for (j in (i + 1):length(behaviors)) {
            brain1 = dd[behavior == behaviors[i], brain_code]
            brain2 = dd[behavior == behaviors[j], brain_code]
            brain_intersect = intersect(brain1, brain2)
            r = c(
                behavior1 = behaviors[i],
                behavior2 = behaviors[j],
                counts = length(brain_intersect)
            )
            join_count[[length(join_count) + 1]] = r
        }
    }
    count_table = join_count %>% ldply
    count_table
}

## Rat joint matrix
dd = d[grepl("R", d$brain_code)]
d1 = gen_count_table(dd)  %>% data.table

## Mouse joint matrix
dd = d[grepl("B", d$brain_code)]
d2 = gen_count_table(dd) %>% data.table

level_v = c(d1$behavior1, d1$behavior2, d2$behavior1, d2$behavior2) %>% unique %>% sort
m1 = matrix('0', nrow = length(level_v), ncol = length(level_v))
for (i in 1:length(level_v)) {
    for (j in i+1:length(level_v)) {
        x = d1[behavior1 == level_v[i] & behavior2 == level_v[j], counts]
        y = d1[behavior1 == level_v[j] & behavior2 == level_v[i], counts]
        if (length(x) != 0) {
            m1[j, i] = x
        } else if (length(y) != 0) {
            m1[j, i] = y
        }
    }
}

for (i in 1:length(level_v)) {
    for (j in i+1:length(level_v)) {
        x = d2[behavior1 == level_v[i] & behavior2 == level_v[j], counts]
        y = d2[behavior1 == level_v[j] & behavior2 == level_v[i], counts]
        if (length(x) != 0) {
            m1[i, j] = x
        } else if (length(y) != 0) {
            m1[i, j] = y
        }
    }
}

for (i in 1:length(level_v)) {
    m1[i, i] = level_v[i]
}

matrix_l = list()
for (i in 1:length(level_v)) {
    matrix_l[[i]] = 
        list(id = level_v[i], value = 
            lapply(1:length(m1[i, ]), function(j) { list(id = m1[i, i], value = m1[i, j], behaviors = c(level_v[i], level_v[j])) })
            )
}

matrix_l %>% jsonlite::toJSON(pretty = T, auto_unbox = T) %>% write("./behavior_correlation_matrix.json")

## Json for front end
## 1. Brain Area list, 2. Behavior list.
d1 = fread("./clean_behavior_brain_area.tsv")
d2 = fread("./clean_brain_area_annotation.tsv")
firstup <- function(x) {
  substr(x, 1, 1) <- toupper(substr(x, 1, 1))
  x
}
behavior = data.frame(value = d1$behavior %>% unique %>% sort)
behavior$display  = behavior$value %>% firstup
brain_area = data.frame(value = d2$brain_code, display = d2$main %>% firstup, species = d2$species)
output = list(behavior = behavior, brain_area = brain_area)

j = jsonlite::toJSON(output, pretty = T)
write(j, './front_end.json')
