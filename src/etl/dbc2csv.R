# convert_dbc_to_csv.R
library(read.dbc)

# Função para converter .dbc para .csv
convert_dbc_to_csv <- function(dbc_file, output_dir) {
  # Criar o nome do arquivo .csv de saída
  csv_file <- file.path(output_dir, paste0(tools::file_path_sans_ext(basename(dbc_file)), ".csv"))

  # Checar se o arquivo .csv já existe
  if (file.exists(csv_file)) {
    print(paste("Arquivo", csv_file, "já existe. Pulando a conversão."))
    return()
  }

  # Ler o arquivo .dbc dentro de um tryCatch
  data <- tryCatch({
    read.dbc(dbc_file)
  }, error = function(e) {
    print(paste("Erro ao ler o arquivo:", dbc_file))
    print(e)
    return(NULL)
  })

  # Verificar se houve erro ao ler o arquivo .dbc
  if (is.null(data)) {
    return()
  }

  # Salvar o data frame como .csv
  write.csv(data, csv_file, row.names = FALSE)
  print(paste("Convertido:", dbc_file, "para", csv_file))
}

# Função principal que será chamada a partir do Python
main <- function(input_dir, output_dir) {
  # Criar o diretório de saída se não existir
  if (!dir.exists(output_dir)) {
    dir.create(output_dir, recursive = TRUE)
  }

  # Listar todos os arquivos .dbc no diretório de entrada
  dbc_files <- list.files(input_dir, pattern = "\\.dbc$", full.names = TRUE)

  # Percorrer e converter cada arquivo .dbc
  for (dbc_file in dbc_files) {
    convert_dbc_to_csv(dbc_file, output_dir)
  }
}

# Captura os argumentos de linha de comando
args <- commandArgs(trailingOnly = TRUE)
input_dir <- args[1]
output_dir <- args[2]

# Chama a função principal com os argumentos passados
main(input_dir, output_dir)
