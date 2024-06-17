# ETL-ML-Dengue
Repositório destinado ao tratamento de dados relacionados à saúde e ao desenvolvimento de um modelo de Machine Learning para previsão de casos de Dengue no Brasil

# Schema do banco de dados

<div align="center">
  <img src="https://github.com/pdrmglc/ETL-ML-Dengue/blob/main/img/postgres%20-%20public.png" alt="schema">
</div>

# Coleta de dados

Os dados foram coletados a partir da base de dados unificada TabNet

## SINAN Dengue

Dados a nível de indivíduo, podendo ser agregados por município e semana ou mês

##  IBGE (Demografia)

### PIB

Dados a nível de município e ano

### População

Dados a nível de município e ano

## SIM (Mortalidade)

Dados a nível de indivíduo, podendo ser agregado por município e semana ou mês

## GISAID (Sequências Genômicas)

Calcular a menor distância entre duas cidades: uma que apresentou detecção de um sorotipo e outra que não. (o quão provável é que os casos desse município tenham sido por causa desse sorotipo/genótipo?). Haverá uma coluna para cada sorotipo/genótipo de interesse para cada mês passado.

Distância rodoviária

Distância de haversine

https://github.com/kelvins/municipios-brasileiros

### Metadados de genótipo/local/data de coleta

**OBS:** parece que não há como automatizar essa parte sem usar webscrap

Manter o seguinte nome ```dengue_brasil_sorotipo_genotipo.tsv```

### Matriz de distância rodoviária entre as cidades do brasil

https://zenodo.org/records/11400243

### Código IBGE municípios

https://www.ibge.gov.br/explica/codigos-dos-municipios.php

## INMET (Clima)
Provavelmente não terão todos os municípios.
Como lidar?
Dados a nível de alguns municípios e por hora

https://portal.inmet.gov.br/dadoshistoricos
https://portal.inmet.gov.br/uploads/dadoshistoricos/2010.zip

## MapBiomas (Uso do Solo)

Dados anuais por município
Difícil de automatizar a coleta posterior

## SISVAN (Nutrição)

Dados são grandes demais para continuar

## CNES

Processamento dos dados feito com a biblioteca https://github.com/rfsaldanha/microdatasus

### ST


#### Estabelecimentos

Dados a nível de indivíduo, podendo ser agregado por município e semana ou mês


### PF

#### Profissionais

Dados a nível de indivíduo, podendo ser agregado por município e semana ou mês


<!-- 
# Dados a serem coletados

## SIH (Hospitalizações)

Dados a nível de indivíduo, podendo ser agregado por município e semana ou mês

## LIRAa (Infestação)

## Google Mobility Reports

## Cadastro Único (Vulnerabilidade Socioeconômica)

## Investimento em saúde?

## E-SUS VE (Vigilância Epidemiológica)

## Instituto Evandro Chagas (Genótipos/Sorotipos)

## Instituto Adolfo Lutz (Genótipos/Sorotipos)

## GenBank (Sequências Genéticas)

## Fiocruz (Vigilância Genômica)

## LACENs (Análise de Amostras Virais)

## Redes Sociais (Sentimento Público)

## Google trends

## Google Analytics (Tendências de Busca)

## INPE (Desmatamento e Queimadas)

## PNAD (Condições de Vida)

## Investimento em lazer

## SISAB (Atenção Básica)

## PAHO (Vigilância Molecular) -->

