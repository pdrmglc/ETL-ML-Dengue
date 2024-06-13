DROP TABLE IF EXISTS "ibge_pop";

CREATE TABLE "ibge_pop" (
    "munic_res" varchar(6) NOT NULL,
    "ano" varchar(4) NOT NULL,
    "populacao" int NOT NULL,
    CONSTRAINT "pk_ibge_pop" PRIMARY KEY ("munic_res", "ano")
);