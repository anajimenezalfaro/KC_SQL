----------------------------------------
-- PRACTICA FINAL  ANA JIMENEZ-ALFARO --
----------------------------------------

-- CONSULTA PRACTICA FINAL  --

	
select 
	   a.licenseplate,
	   a.datepurchase,
	   a.totalkms,
	   b.carmodel,
	   c.carbrand,
	   d.carcompany,
	   e.colour,
	   f.npolicy,
	   g.insurancecompany
	   
	from ana_jimenez_alfaro.cars a
	inner join ana_jimenez_alfaro.types_model b on a.idcarmodel = b.idcarmodel
	inner join ana_jimenez_alfaro.types_brand c on b.idcarbrand  = c.idcarbrand 
	inner join ana_jimenez_alfaro.types_car_company d on c.idcarcompany= d.idcarcompany
	inner join ana_jimenez_alfaro.types_colours e on a.idcolour  = e.idcolour 	
	inner join ana_jimenez_alfaro.insurance_policies f on a.idcar = f.idcar
	inner join ana_jimenez_alfaro.types_insurance_companies g on f.idinsurancecompany  = g.idinsurancecompany 