library(data.table)

# Gaulfoss
tmp = list()
tmp[[1]] = fread("data/122.9_GaulfossNedb�r.csv", skip = 1, col.names = c('dato', 'nedb�r'))
tmp[[2]] = fread("data/122.9_GaulfossSn�dekningsgrad.csv", skip = 1, col.names = c('dato', 'sn�dekningsgrad'))
tmp[[3]] = fread("data/122.9_GaulfossSn�ensVannekvivalent.csv", skip = 1, col.names = c('dato', 'sn�vannekvivalent'))
tmp[[4]] = fread("data/122.9_GaulfossTemperatur.csv", skip = 1, col.names = c('dato', 'temperatur'))
tmp[[5]] = fread("data/122.9_GaulfossVF.csv", skip = 1, col.names = c('dato', 'VF'))
tmp[[6]] = fread("data/122.9_GaulfossVST.csv", skip = 1, col.names = c('dato', 'VST'))
tmp[[7]] = fread("data/122.9_GaulfossModellertVannf�ring.csv", skip = 1, col.names = c('dato', 'MVF'))

# Change to date format and merge all the tables together on 'dato'
# Full outer join, creates missing values for VF and VST
tmp[[1]][['dato']] = as.Date(tmp[[1]][['dato']])
data_raw_gaulfoss = tmp[[1]]
for (i in 2:length(tmp)) {
  tmp[[i]][['dato']] = as.Date(tmp[[i]][['dato']])
  data_raw_gaulfoss = merge(data_raw_gaulfoss, tmp[[i]], by = "dato", all = TRUE)
}

saveRDS(data_raw_gaulfoss, file = "raw_data_gaulfoss.rds")

# Eggafoss
tmp = list()
tmp[[1]] = fread("data/122.11_EggafossNedb�r.csv", skip = 1, col.names = c('dato', 'nedb�r'))
tmp[[2]] = fread("data/122.11_EggafossSn�dekningsgrad.csv", skip = 1, col.names = c('dato', 'sn�dekningsgrad'))
tmp[[3]] = fread("data/122.11_EggafossSn�Vannekvivalent.csv", skip = 1, col.names = c('dato', 'sn�vannekvivalent'))
tmp[[4]] = fread("data/122.11_EggafossTemperatur.csv", skip = 1, col.names = c('dato', 'temperatur'))
tmp[[5]] = fread("data/122.11_EggafossVF.csv", skip = 1, col.names = c('dato', 'VF'))
tmp[[6]] = fread("data/122.11_EggafossVST.csv", skip = 1, col.names = c('dato', 'VST'))
tmp[[7]] = fread("data/122.11_EggafossModellertVannf�ring.csv", skip = 1, col.names = c('dato', 'MVF'))

tmp[[1]][['dato']] = as.Date(tmp[[1]][['dato']], "%d.%m.%Y %H:%M")
data_raw_eggafoss = tmp[[1]]
for (i in 2:length(tmp)) {
  tmp[[i]][['dato']] = as.Date(tmp[[i]][['dato']], "%d.%m.%Y %H:%M")
  data_raw_eggafoss = merge(data_raw_eggafoss, tmp[[i]], by = "dato", all = TRUE)
}

saveRDS(data_raw_eggafoss, file = "raw_data_eggafoss.rds")

# Rate
tmp = list()
tmp[[1]] = fread("data/123.20_RateVF.csv", skip = 1, col.names = c('dato', 'VF'))
tmp[[2]] = fread("data/123.20_RateVST.csv", skip = 1, col.names = c('dato', 'VST'))

tmp[[1]][['dato']] = as.Date(tmp[[1]][['dato']])
tmp[[2]][['dato']] = as.Date(tmp[[2]][['dato']])

data_raw_rate = merge(tmp[[1]], tmp[[2]], by = "dato", all = TRUE)
saveRDS(data_raw_rate, file = "raw_data_rate.rds")