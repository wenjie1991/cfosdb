#!/usr/bin/env Rscript 

library(RSQLite)
library(data.table)
library(stringr)
library(stringi)

d1 = fread("./clean_behavior_brain_area.tsv")
d1$behavior %<>% revalue(c("agression" = "aggression"))
j1 = jsonlite::toJSON(d1, pretty = T)
write(j1, "./clean_behavior_brain_area.json")

d2 = fread("./clean_brain_area_annotation.tsv")
d2$abbr = d2$long %>% stri_reverse() %>%  str_split_fixed("[()]", 3) %>% extract(, 2) %>% stri_reverse()
j2 = jsonlite::toJSON(d2, pretty = T)
write(j2, "./clean_brain_area_annotation.json")

## behavior overlap
d = fread("./clean_behavior_brain_area.tsv")
d$behavior %<>% revalue(c("agression" = "aggression"))

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

dd = d[grepl("R", d$brain_code)]
gen_count_table(dd) %>% jsonlite::toJSON(pretty=T) %>% write("./rat_joint_matrix.json")

dd = d[grepl("B", d$brain_code)]
gen_count_table(dd) %>% jsonlite::toJSON(pretty=T) %>% write("./mouse_joint_matrix.json")

## Explore
# d = fread("./clean_brain_area_annotation.tsv")
# x = d$brain_code %>% strsplit("\\.") %>% sapply(function(x) {x[1]})
# x = unique(x)
# sum(x %in% d$brain_code)
