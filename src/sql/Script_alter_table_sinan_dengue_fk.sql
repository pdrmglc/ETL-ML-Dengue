ALTER TABLE "sinan_dengue"
ADD CONSTRAINT "fk_sinan_dengue_ibge_pib"
FOREIGN KEY ("id_municip", "nu_ano")
REFERENCES "ibge_pib" ("codigo_municipio", "ano_notificacao");


ALTER TABLE "sinan_dengue"
ADD CONSTRAINT "fk_sinan_dengue_ibge_pop"
FOREIGN KEY ("id_municip", "nu_ano")
REFERENCES "ibge_pop" ("munic_res", "ano");
