
CREATE TABLE agrupado.sim_agrupado AS

with tabela_dia_semana as (
SELECT 
  f.codigo_municipio,
  f.nu_mes,
  f.nu_ano,
  sum(CASE WHEN f.day_of_week = 'Thursday ' THEN 1 ELSE 0 END) as ctg_day_of_week_Thursday,
  sum(CASE WHEN f.day_of_week = 'Wednesday' THEN 1 ELSE 0 END) as ctg_day_of_week_Wednesday,
  sum(CASE WHEN f.day_of_week = 'Saturday ' THEN 1 ELSE 0 END) as ctg_day_of_week_Saturday,
  sum(CASE WHEN f.day_of_week = 'Monday   ' THEN 1 ELSE 0 END) as ctg_day_of_week_Monday,
  sum(CASE WHEN f.day_of_week = 'Friday   ' THEN 1 ELSE 0 END) as ctg_day_of_week_Friday,
  sum(CASE WHEN f.day_of_week = 'Tuesday  ' THEN 1 ELSE 0 END) as ctg_day_of_week_Tuesday,
  sum(CASE WHEN f.day_of_week = 'Sunday' THEN 1 ELSE 0 END) as ctg_day_of_week_Sunday,
  (sum(CASE WHEN f.day_of_week = 'Thursday ' THEN 1 ELSE 0 END)::numeric/count(f.sim_id))*100 as pct_day_of_week_Thursday,
  (sum(CASE WHEN f.day_of_week = 'Wednesday' THEN 1 ELSE 0 END)::numeric/count(f.sim_id))*100 as pct_day_of_week_Wednesday,
  (sum(CASE WHEN f.day_of_week = 'Saturday ' THEN 1 ELSE 0 END)::numeric/count(f.sim_id))*100 as pct_day_of_week_Saturday,
  (sum(CASE WHEN f.day_of_week = 'Monday   ' THEN 1 ELSE 0 END)::numeric/count(f.sim_id))*100 as pct_day_of_week_Monday,
  (sum(CASE WHEN f.day_of_week = 'Friday   ' THEN 1 ELSE 0 END)::numeric/count(f.sim_id))*100 as pct_day_of_week_Friday,
  (sum(CASE WHEN f.day_of_week = 'Tuesday  ' THEN 1 ELSE 0 END)::numeric/count(f.sim_id))*100 as pct_day_of_week_Tuesday,
  (sum(CASE WHEN f.day_of_week = 'Sunday' THEN 1 ELSE 0 END)::numeric/count(f.sim_id))*100 as pct_day_of_week_Sunday
  from (select s.codigo_municipio,
  s.sim_id,
  s.nu_mes,
  s.nu_ano,
  s.dtobito,
  TO_CHAR(s.dtobito, 'Day') AS day_of_week from public.sim s) as f
 GROUP BY f.codigo_municipio, f.nu_mes, f.nu_ano),

restante_tabela as (
SELECT 
  s.codigo_municipio,
  s.nu_mes,
  s.nu_ano,
  count(s.sim_id),
  sum(CASE WHEN s.sexo IS NULL THEN 1 ELSE 0 END) as sum_sexo_null,
  sum(CASE WHEN s.sexo = 'Feminino' THEN 1 ELSE 0 END) as sum_sexo_fem,
  sum(CASE WHEN s.sexo = 'Masculino' THEN 1 ELSE 0 END) as sum_sexo_mas,
  sum(CASE WHEN s.sexo = 'Ignorado' THEN 1 ELSE 0 END) as sum_sexo_ign,
  (sum(CASE WHEN s.sexo IS NULL THEN 1 ELSE 0 END)::numeric/count(s.sim_id))*100 as pct_sexo_null,
  (sum(CASE WHEN s.sexo = 'Feminino' THEN 1 ELSE 0 END)::numeric/count(s.sim_id))*100 as pct_sexo_fem,
  (sum(CASE WHEN s.sexo = 'Masculino' THEN 1 ELSE 0 END)::numeric/count(s.sim_id))*100 as pct_sexo_mas,
  (sum(CASE WHEN s.sexo = 'Ignorado' THEN 1 ELSE 0 END)::numeric/count(s.sim_id))*100 as pct_sexo_ign,
  sum(CASE WHEN s.idade_anos IS NULL THEN 1 ELSE 0 END) as ctg_idade_anos_null,
  AVG(CASE WHEN s.idade_anos IS NULL THEN 1 ELSE 0 END) as media_idade_anos_null,
  AVG(idade_anos) AS media_idade_anos,
  PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY idade_anos) AS mediana_idade_anos,
  STDDEV(idade_anos) AS dp_idade_anos,
  PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY idade_anos) - PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY idade_anos) AS iiq_idade_anos,
  MAX(idade_anos) AS max_idade_anos,
  MIN(idade_anos) AS min_idade_anos
FROM public.sim s 
GROUP BY s.codigo_municipio, s.nu_mes, s.nu_ano)

SELECT 
  r.*,
  t.ctg_day_of_week_Thursday,
  t.ctg_day_of_week_Wednesday,
  t.ctg_day_of_week_Saturday,
  t.ctg_day_of_week_Monday,
  t.ctg_day_of_week_Friday,
  t.ctg_day_of_week_Tuesday,
  t.ctg_day_of_week_Sunday,
  t.pct_day_of_week_Thursday,
  t.pct_day_of_week_Wednesday,
  t.pct_day_of_week_Saturday,
  t.pct_day_of_week_Monday,
  t.pct_day_of_week_Friday,
  t.pct_day_of_week_Tuesday,
  t.pct_day_of_week_Sunday
FROM 
  restante_tabela r
JOIN 
  tabela_dia_semana t
ON 
  r.codigo_municipio = t.codigo_municipio AND
  r.nu_mes = t.nu_mes AND
  r.nu_ano = t.nu_ano;
  
 
 
 
SELECT *
FROM agrupado.sinan_dengue_agrupado sda
LEFT JOIN public.biomaps b 
    ON b.id_municip = sda.codigo_municipio 
    AND b.nu_ano = sda.nu_ano
LEFT JOIN agrupado.sim_agrupado sa 
    ON sa.codigo_municipio = sda.codigo_municipio 
    AND sa.nu_mes = sda.nu_mes 
    AND sa.nu_ano = sda.nu_ano
LEFT JOIN public.inmet i 
    ON i.id_municip = sda.codigo_municipio 
    AND i.nu_mes = sda.nu_mes 
    AND i.nu_ano = sda.nu_ano
LEFT JOIN agrupado.cnes_st_agrupado1 csa 
    ON csa.codufmun = sda.codigo_municipio 
    AND csa.nu_mes = sda.nu_mes 
    AND csa.nu_ano = sda.nu_ano
LEFT JOIN agrupado.cnes_st_agrupado2 csa2 
    ON csa2.codufmun = sda.codigo_municipio 
    AND csa2.nu_mes = sda.nu_mes 
    AND csa2.nu_ano = sda.nu_ano
LEFT JOIN public.ibge_pib ip 
    ON ip.codigo_municipio = sda.codigo_municipio 
    AND ip.ano_notificacao = sda.nu_ano
LEFT JOIN public.ibge_pop ip2 
    ON ip2.munic_res = sda.codigo_municipio 
    AND ip2.ano = sda.nu_ano
ORDER BY sda.codigo_municipio, sda.nu_ano, sda.nu_mes;
