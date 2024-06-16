DROP TABLE IF EXISTS "cnes_pf";

CREATE TABLE "cnes_pf" (
    "cnes_pf_id" SERIAL,
    "cnes" VARCHAR(7) NOT NULL,
    "codufmun" VARCHAR(6) NOT NULL,
    "nu_mes" VARCHAR(2) NOT NULL, 
    "nu_ano" VARCHAR(4) NOT NULL,
    "vincul_c" VARCHAR(3), 
    "vincul_a" VARCHAR(3), 
    "vincul_n" VARCHAR(3), 
    "prof_sus" VARCHAR(3), 
    "profnsus" VARCHAR(3), 
    "horaoutr" INT, 
    "horahosp" INT, 
    "hora_amb" INT, 
    "competen" VARCHAR(6),
    "nome" VARCHAR(100),
    PRIMARY KEY ("cnes_pf_id")
);