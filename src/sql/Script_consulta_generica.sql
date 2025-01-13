select ip.munic_res, ip.ano, avg(populacao) from public.ibge_pop ip
where ip.munic_res = '230440'
group by ip.munic_res, ip.ano;


INSERT INTO agrupado.teste (munic_res, media_pop)
SELECT ip.munic_res, AVG(ip.populacao) AS media_populacao
FROM public.ibge_pop ip
GROUP BY ip.munic_res;


select s.nu_ano, count(s.nu_ano) from public.sinan_dengue s
group by s.nu_ano;

select sim.codigo_municipio, sim.nu_mes, sim.nu_ano, count(sim.dtobito) as num_obitos from public.sim sim
group by sim.codigo_municipio, sim.nu_mes, sim.nu_ano
order by num_obitos desc;


