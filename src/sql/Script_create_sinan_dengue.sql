DROP TABLE IF EXISTS "sinan_dengue";

CREATE TABLE "sinan_dengue" (
    "sinan_dengue_id" SERIAL PRIMARY KEY,
    "nu_ano" varchar(4) NOT NULL,
    "nu_mes" varchar(2) NOT NULL,
    "id_municip" varchar(6) NOT NULL,
    "dt_notific" date NOT NULL,
    "sem_not" varchar(6),
    "dt_sin_pri" date,
    "sem_pri" varchar(6),
    "nu_idade_n" varchar(4),
    "idade_anos" float,
    "cs_sexo" varchar(1),
    "cs_gestant" varchar(1),
    "cs_raca" varchar(1),
    "cs_escol_n" varchar(2),
    "sg_uf" varchar(2),
    "id_mn_resi" varchar(6),
    "id_pais" varchar(1),
    "nduplic_n" varchar(1),
    "dt_invest" date,
    "dt_soro" date,
    "resul_soro" varchar(1),
    "dt_ns1" date,
    "resul_ns1" varchar(1),
    "dt_viral" date,
    "resul_vi_n" varchar(1),
    "dt_pcr" date,
    "resul_pcr_" varchar(1),
    "sorotipo" varchar(1),
    "histopa_n" varchar(1),
    "imunoh_n" varchar(1),
    "classi_fin" varchar(1),
    "criterio" varchar(2),
    "tpautocto" varchar(1),
    "coufinf" varchar(2),
    "copaisinf" varchar(4),
    "comuninf" varchar(6),
    "evolucao" varchar(1),
    "dt_obito" date,
    "dt_encerra" date,
    "mani_hemor" varchar(1),
    "epistaxe" varchar(1),
    "gengivo" varchar(1),
    "metro" varchar(1),
    "petequias" varchar(1),
    "hematura" varchar(1),
    "sangram" varchar(1),
    "laco_n" varchar(1),
    "plasmatico" varchar(1),
    "evidencia" varchar(1),
    "complica" varchar(1),
    "hospitaliz" varchar(1),
    "dt_interna" date,
    "uf" varchar(2),
    "municipio" varchar(6),
    CONSTRAINT "fk_sinan_dengue_ibge_pop"
        FOREIGN KEY ("id_municip", "nu_ano")
        REFERENCES "ibge_pop" ("munic_res", "ano"),
    CONSTRAINT "fk_sinan_dengue_ibge_pib"
        FOREIGN KEY ("id_municip", "nu_ano")
        REFERENCES "ibge_pib" ("codigo_municipio", "ano_notificacao")
);
