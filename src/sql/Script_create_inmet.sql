DROP TABLE IF EXISTS "inmet";

CREATE TABLE "inmet" (
    "inmet_id" SERIAL,
	"id_municip" varchar(6) NOT NULL, 
	"uf" varchar(2), 
	"nu_mes" varchar(2) NOT NULL, 
	"nu_ano" varchar(4) NOT NULL, 
	"precipitacao_total_mm" float, 
	"pressao_atm_nivel_estacao_mb" float, 
	"pressao_atm_max_mb" float, 
	"pressao_atm_min_mb" float, 
	"radiacao_global_kj_m2" float, 
	"temp_bulbo_seco_c" float, 
	"temp_ponto_orvalho_c" float, 
	"temp_max_c" float, 
	"temp_min_c" float, 
	"orvalho_max_c" float, 
	"orvalho_min_c" float, 
	"umidade_rel_max_perc" float, 
	"umidade_rel_min_perc" float, 
	"umidade_rel_horaria_perc" float, 
	"vento_direcao_gr" float, 
	"vento_rajada_max_ms" float, 
	"vento_velocidade_horaria_ms" float, 
    PRIMARY KEY ("inmet_id")
);