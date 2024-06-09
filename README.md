# ETL-ML-Dengue
Repositório destinado à tratamento de dados do IBGE e desenvolvimento de um modelo de ML para previsão de casos de Dengue no Brasil

# Coleta de dados

Os dados foram coletados a partir da base de dados unificada TabNet

## SINAN Dengue

Dados a nível de indivíduo, podendo ser agregados por município e semana ou mês

##  IBGE (Demografia)

Dados a nível de município e ano

## SIM (Mortalidade)

Dados a nível de indivíduo, podendo ser agregado por município e semana ou mês

## GISAID (Sequências Genômicas)

Calcular a menor distância entre duas cidades: uma que apresentou detecção de um sorotipo e outra que não. (o quão provável é que os casos desse município tenham sido por causa desse sorotipo/genótipo?). Haverá uma coluna para cada sorotipo/genótipo de interesse para cada mês passado.

### Metadados de genótipo/local/data de coleta

**OBS:** parece que não há como automatizar essa parte sem usar webscrap

Manter o seguinte nome ```dengue_brasil_sorotipo_genotipo.tsv```

### Matriz de distância rodoviária entre as cidades do brasil

https://zenodo.org/records/11400243

### Código IBGE municípios

https://www.ibge.gov.br/explica/codigos-dos-municipios.php

# Dados a serem coletados

## SIH (Hospitalizações)

Dados a nível de indivíduo, podendo ser agregado por município e semana ou mês

## CNES

## INMET (Clima)
Provavelmente não terão todos os municípios.
Como lidar?
Dados a nível de alguns municípios e por hora

https://portal.inmet.gov.br/dadoshistoricos
https://portal.inmet.gov.br/uploads/dadoshistoricos/2010.zip

## E-SUS VE (Vigilância Epidemiológica)

## Instituto Evandro Chagas (Genótipos/Sorotipos)

## Instituto Adolfo Lutz (Genótipos/Sorotipos)

## GenBank (Sequências Genéticas)

## Fiocruz (Vigilância Genômica)

## LACENs (Análise de Amostras Virais)

## Redes Sociais (Sentimento Público)

## LIRAa (Infestação)

## Google trends

## Google Analytics (Tendências de Busca)

## Google Mobility Reports

## MapBiomas (Uso do Solo)

## INPE (Desmatamento e Queimadas)

## Cadastro Único (Vulnerabilidade Socioeconômica)

## PNAD (Condições de Vida)



## Faturamento por município

## Investimento em saúde?

## Investimento em lazer

## SISAB (Atenção Básica)


## PAHO (Vigilância Molecular)


