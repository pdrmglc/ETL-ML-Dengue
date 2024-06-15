ALTER TABLE "Sinan_dengue"
ADD CONSTRAINT "fk_Sinan_dengue_Ibge_pib"
FOREIGN KEY ("ID_MUNICIP", "NU_ANO")
REFERENCES "Ibge_pib" ("codigo_municipio", "ano_notificacao");
