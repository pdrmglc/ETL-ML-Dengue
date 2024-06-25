select ip.munic_res, avg(populacao) from public.ibge_pop ip
group by ip.munic_res;


INSERT INTO agrupado.teste (munic_res, media_pop)
SELECT ip.munic_res, AVG(ip.populacao) AS media_populacao
FROM public.ibge_pop ip
GROUP BY ip.munic_res;


select s.nu_ano, count(s.nu_ano) from public.sinan_dengue s
group by s.nu_ano;