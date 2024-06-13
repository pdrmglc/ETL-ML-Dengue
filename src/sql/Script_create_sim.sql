DROP TABLE IF EXISTS "sim";

CREATE TABLE "sim" (
	"sim_id" SERIAL NOT NULL,
	"codigo_municipio" varchar(6) NOT NULL,
	"nu_mes" varchar(2) NOT NULL, 
	"nu_ano" varchar(4) NOT NULL,
	"tipobito" varchar(10),
	"dtobito" date NOT NULL,
	"natural" varchar(3),
	"dtnasc" date,
	"idade" varchar(3),
	"idade_anos" float,
	"sexo" varchar(1),
	"racacor" varchar(8),
	"estciv" varchar(8),
	"esc" varchar(20),
	"codmunres" varchar(7),
	"lococor" varchar(32),
	"codmunocor" varchar(8),
	"idademae" int,
	"escmae" varchar(14),
	"gravidez" varchar(13),
	"gestacao" varchar(50),
	"parto" varchar(10),
	"obitoparto" varchar(10),
	"peso" int,
	"obitograv" varchar(10),
	"obitopuerp" varchar(50),
	"assistmed" varchar(10),
	"exame" varchar(10),
	"cirurgia" varchar(10),
	"necropsia" varchar(10),
	"linhaa" varchar(256),
	"linhab" varchar(256),
	"linhac" varchar(256),
	"linhad" varchar(256),
	"linhaii" varchar(256),
	"causabas" varchar(4),
	"comunsvoim" varchar(14), 
	"dtatestado" date,
	"circobito" varchar(14),
	"acidtrab" varchar(10),
	"fonte" varchar(30),
	"tppos" varchar(3),
	"dtinvestig" date,
	"causabas_o" varchar(4),
	"dtcadastro" date,
	"fonteinv" varchar(50),
	"dtrecebim" date,
	"dtrecorig" date,
	"dtrecoriga" date,
	"causamat" varchar(4),
	"esc2010" varchar(30),
	"escmae2010" varchar(30),
	"stdoepidem" varchar(3),
	"stdonova" varchar(3),
	"tpobitocor" varchar(256),
	"dtcadinf" date,
    PRIMARY KEY ("codigo_municipio", "nu_mes", "nu_ano", "sim_id")
);