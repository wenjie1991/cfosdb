library(data.table)
library(magrittr)
library(readr)

d1 = fread("./data_table/behavior_nucleic_relation-Table 1.tsv")
# d1[species == 'rat', brain_code := paste0('R', brain_code)]
write_tsv(d1, "./clean_behavior_brain_area.tsv")

d2_r = fread("./data_table/rat_brain_area_annotation-Table 1.tsv")
d2_m = fread("./data_table/mouse_brain_area_annotation-Table 1.tsv")
colname_v = c(
    'brain_code'
    , 'main'
    , 'species'
    , 'long_1'
    , 'short_1'
    , 'long_2'
    , 'short_2'
    , 'long_3'
    , 'short_3'
)
names(d2_r) = colname_v
names(d2_m) = colname_v

# d2_r$brain_code %<>% paste0("R", .)
d2 = rbind(d2_r, d2_m)

write_tsv(d2, "./clean_brain_area_annotation.tsv")

