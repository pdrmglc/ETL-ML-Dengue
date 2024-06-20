DROP TABLE IF EXISTS "cnes_st";

CREATE TABLE "cnes_st" (
    "cnes_st_id" SERIAL,
    "cnes" VARCHAR(7) NOT NULL,
    "codufmun" VARCHAR(6) NOT NULL,
    "nu_mes" VARCHAR(2) NOT NULL, 
    "nu_ano" VARCHAR(4) NOT NULL,
    "competen" VARCHAR(6),
    "vinc_sus" VARCHAR(3),
    "pf_pj" VARCHAR(20),
    "niv_dep" VARCHAR(20),
    "cod_ir" VARCHAR(50),
    "esfera_a" VARCHAR(30),
	"retencao" VARCHAR(50),
	"atividad" VARCHAR(50),
	"natureza" VARCHAR(50),
	"clientel" VARCHAR(50),
	"turno_at" VARCHAR(50),
	"niv_hier" VARCHAR(50),
	"tp_prest" VARCHAR(50),
    "tpgestao" VARCHAR(20),
    "av_acred" VARCHAR(3),
    "orgexped" VARCHAR(3),
    "clasaval" VARCHAR(50),
    "av_pnass" VARCHAR(3),
    "gesprg1e" VARCHAR(3),
    "gesprg1m" VARCHAR(3),
    "gesprg2e" VARCHAR(3),
    "gesprg2m" VARCHAR(3),
    "gesprg4e" VARCHAR(3),
    "gesprg4m" VARCHAR(3),
    "nivate_a" VARCHAR(3),
    "gesprg3e" VARCHAR(3),
    "gesprg3m" VARCHAR(3),
    "gesprg5e" VARCHAR(3),
    "gesprg5m" VARCHAR(3),
    "gesprg6e" VARCHAR(3),
    "gesprg6m" VARCHAR(3),
    "nivate_h" VARCHAR(3),
    "qtleitp1" INT,
    "qtleitp2" INT,
    "qtleitp3" INT,
    "leithosp" VARCHAR(3),
    "qtinst01" INT, 
    "qtinst02" INT, 
    "qtinst03" INT, 
    "qtinst04" INT, 
    "qtinst05" INT, 
    "qtinst06" INT, 
    "qtinst07" INT, 
    "qtinst08" INT, 
    "qtinst09" INT, 
    "qtinst10" INT, 
    "qtinst11" INT, 
    "qtinst12" INT, 
    "qtinst13" INT, 
    "qtinst14" INT,
    "urgemerg" VARCHAR(3),
    "qtinst15" INT, 
    "qtinst16" INT, 
    "qtinst17" INT, 
    "qtinst18" INT, 
    "qtinst19" INT, 
    "qtinst20" INT, 
    "qtinst21" INT, 
    "qtinst22" INT, 
    "qtinst23" INT, 
    "qtinst24" INT, 
    "qtinst25" INT, 
    "qtinst26" INT, 
    "qtinst27" INT, 
    "qtinst28" INT, 
    "qtinst29" INT, 
    "qtinst30" INT,
    "atendamb" VARCHAR(3),
    "qtinst31" INT, 
    "qtinst32" INT, 
    "qtinst33" INT, 
    "centrcir" VARCHAR(3), 
    "qtinst34" INT, 
    "qtinst35" INT, 
    "qtinst36" INT, 
    "qtinst37" INT, 
    "centrobs" VARCHAR(3), 
    "qtleit05" INT, 
    "qtleit06" INT, 
    "qtleit07" INT, 
    "qtleit08" INT, 
    "qtleit09" INT, 
    "qtleit19" INT, 
    "qtleit20" INT, 
    "qtleit21" INT, 
    "qtleit22" INT, 
    "qtleit23" INT, 
    "qtleit32" INT, 
    "qtleit34" INT, 
    "qtleit38" INT, 
    "qtleit39" INT, 
    "qtleit40" INT,
    "centrneo" VARCHAR(3),
    "atendhos" VARCHAR(3),
    "serap01p" VARCHAR(3),
    "serap01t" VARCHAR(3),
    "serap02p" VARCHAR(3),
    "serap02t" VARCHAR(3),
    "serap03p" VARCHAR(3),
    "serap03t" VARCHAR(3),
    "serap04p" VARCHAR(3),
    "serap04t" VARCHAR(3),
    "serap05p" VARCHAR(3),
    "serap05t" VARCHAR(3),
    "serap06p" VARCHAR(3),
    "serap06t" VARCHAR(3),
    "serap07p" VARCHAR(3),
    "serap07t" VARCHAR(3),
    "serap08p" VARCHAR(3),
    "serap08t" VARCHAR(3),
    "serap09p" VARCHAR(3),
    "serap09t" VARCHAR(3),
    "serap10p" VARCHAR(3),
    "serap10t" VARCHAR(3),
    "serap11p" VARCHAR(3),
    "serap11t" VARCHAR(3),
    "serapoio" VARCHAR(3),
    "res_biol" VARCHAR(3),
    "res_quim" VARCHAR(3),
    "res_radi" VARCHAR(3),
    "res_comu" VARCHAR(3),
    "coletres" VARCHAR(3),
    "comiss01" VARCHAR(3),
    "comiss02" VARCHAR(3),
    "comiss03" VARCHAR(3),
    "comiss04" VARCHAR(3),
    "comiss05" VARCHAR(3),
    "comiss06" VARCHAR(3),
    "comiss07" VARCHAR(3),
    "comiss08" VARCHAR(3),
    "comiss09" VARCHAR(3),
    "comiss10" VARCHAR(3),
    "comiss11" VARCHAR(3),
    "comiss12" VARCHAR(3),
    "comissao" VARCHAR(3),
    "ap01cv01" VARCHAR(3),
    "ap01cv02" VARCHAR(3),
    "ap01cv03" VARCHAR(3),
    "ap01cv04" VARCHAR(3),
    "ap01cv05" VARCHAR(3),
    "ap01cv06" VARCHAR(3),
    "ap02cv01" VARCHAR(3),
    "ap02cv02" VARCHAR(3),
    "ap02cv03" VARCHAR(3),
    "ap02cv04" VARCHAR(3),
    "ap02cv05" VARCHAR(3),
    "ap02cv06" VARCHAR(3),
    "ap03cv01" VARCHAR(3),
    "ap03cv02" VARCHAR(3),
    "ap03cv03" VARCHAR(3),
    "ap03cv04" VARCHAR(3),
    "ap03cv05" VARCHAR(3),
    "ap03cv06" VARCHAR(3),
    "ap04cv01" VARCHAR(3),
    "ap04cv02" VARCHAR(3),
    "ap04cv03" VARCHAR(3),
    "ap04cv04" VARCHAR(3),
    "ap04cv05" VARCHAR(3),
    "ap04cv06" VARCHAR(3),
    "ap05cv01" VARCHAR(3),
    "ap05cv02" VARCHAR(3),
    "ap05cv03" VARCHAR(3),
    "ap05cv04" VARCHAR(3),
    "ap05cv05" VARCHAR(3),
    "ap05cv06" VARCHAR(3),
    "ap06cv01" VARCHAR(3),
    "ap06cv02" VARCHAR(3),
    "ap06cv03" VARCHAR(3),
    "ap06cv04" VARCHAR(3),
    "ap06cv05" VARCHAR(3),
    "ap06cv06" VARCHAR(3),
    "ap07cv01" VARCHAR(3),
    "ap07cv02" VARCHAR(3),
    "ap07cv03" VARCHAR(3),
    "ap07cv04" VARCHAR(3),
    "ap07cv05" VARCHAR(3),
    "ap07cv06" VARCHAR(3),
    "atend_pr" VARCHAR(3),
    PRIMARY KEY ("cnes_st_id")
);