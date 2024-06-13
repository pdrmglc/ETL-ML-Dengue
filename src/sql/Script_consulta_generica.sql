select
sd."NU_ANO",
sd."ID_MUNICIP",
sd."DT_NOTIFIC",
ip."POPULACAO" 
from 
	"Sinan_dengue" sd
join
	"Ibge_pop" ip
on
	sd."NU_ANO" = ip."ANO"
and 
	sd."ID_MUNICIP" = ip."MUNIC_RES" 
where
ip."POPULACAO" > 40000;
