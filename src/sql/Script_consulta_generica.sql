select ip.munic_res, avg(populacao) from public.ibge_pop ip
group by ip.munic_res;


INSERT INTO agrupado.teste (munic_res, media_pop)
SELECT ip.munic_res, AVG(ip.populacao) AS media_populacao
FROM public.ibge_pop ip
GROUP BY ip.munic_res;