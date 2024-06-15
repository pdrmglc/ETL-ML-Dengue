#!/usr/bin/env Rscript

# Carregar biblioteca necessária
library(microdatasus)

# Capturar os argumentos da linha de comando
args <- commandArgs(trailingOnly = TRUE)

# Atribuir os argumentos a variáveis
ano_inicio <- as.integer(args[1])
mes_inicio <- as.integer(args[2])
ano_fim <- as.integer(args[3])
mes_fim <- as.integer(args[4])
uf <- args[5]
banco <- args[6]
diretorio_saida <- args[7]

# Executar as funções necessárias
df <- fetch_datasus(year_start = ano_inicio, month_start = mes_inicio,
                     year_end = ano_fim, month_end = mes_fim,
                     uf = uf,
                     information_system = banco)
df_a <- process_cnes(df, information_system = banco)

# Salvar o resultado em um arquivo CSV
write.csv(df_a, diretorio_saida, row.names = FALSE)