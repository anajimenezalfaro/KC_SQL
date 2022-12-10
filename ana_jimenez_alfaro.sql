----------------------------------------
-- PRACTICA FINAL  ANA JIMENEZ-ALFARO --
----------------------------------------

-- CREAMOS SCHEMA -- 

create schema ana_jimenez_alfaro authorization oodhuafv; --usuario profesor

-- CREAMOS TABLAS ESQUEMA -- 


-- Tabla grupos empresariales de coches -- 

create table ana_jimenez_alfaro.types_car_company (
	idCarCompany varchar(4) not null, --PK 
	carCompany varchar(50) not null,
	constraint types_car_company_PK primary key (idCarCompany),
	comments varchar(250) null 

);

-- Tabla marcas de coches -- 

create table ana_jimenez_alfaro.types_brand (
	idCarBrand varchar(5) not null, -- PK 
	idCarCompany varchar(4) not null, --FK --> types_car_company(idCarCompany) 
	carBrand varchar(100) not null, 
	constraint types_brand_PK primary key(idCarBrand),
	constraint types_brand_car_company_FK foreign key (idCarCompany)
	references ana_jimenez_alfaro.types_car_company (idCarCompany),
	comments varchar(250) null 

);


-- Tabla modelos de coches -- 

create table ana_jimenez_alfaro.types_model (
	idCarModel varchar (3) not null, --PK
	idCarBrand varchar(5) not null, -- FK --> types_brand(idCarBrand) 
	carModel varchar(250) not null, 
	constraint types_model_PK primary key (idCarModel),
	constraint types_model_brand_FK foreign key (idCarBrand)
	references ana_jimenez_alfaro.types_brand (idCarBrand),
	comments varchar(250) null 

);

-- Tabla colores de coches -- 

create table ana_jimenez_alfaro.types_colours (
	idColour varchar (3) not null, --PK
	colour varchar(50) not null,
	constraint types_colour_PK primary key (idColour),
	comments varchar(250) null 

);

-- tabla tipos de compañias de seguros --

create table ana_jimenez_alfaro.types_insurance_companies (
	idInsuranceCompany varchar (3) not null, --PK
	insuranceCompany varchar (200) not null, 
	constraint types_insurance_companies_PK primary key (idInsuranceCompany),
	comments varchar(250) null 

);



-- tabla tipos polizas -- 

create table ana_jimenez_alfaro.types_policies 	 (
	idTypePolicy varchar (2) not null, --PK
	constraint types_polices_PK primary key (idTypePolicy),
	typePolicy varchar(20) not null
	
);



-- tabla tipo moneda --

create table ana_jimenez_alfaro.types_currency	 (
	idCurrency varchar (3) not null default 'EUR', --PK
	nameCurrency varchar(100) not null default 'Euro',
	constraint types_currency_PK primary key (idCurrency),
	comments varchar(250) null
		
);


-- tabla cambio de moneda --

create table ana_jimenez_alfaro.currency_exchange 	 (
	idCurrency varchar (3) not null default 'EUR', --PK,FK --> types_currency(idCurrency)
	currencyExchange numeric not null,
	constraint currency_exchange_PK primary key (idCurrency),
	constraint currency_exchange_types_FK foreign key (idCurrency)
	references ana_jimenez_alfaro.types_currency (idCurrency)
		
);



-- tabla coches -- 

create table ana_jimenez_alfaro.cars (
	idCar varchar (200) not null, --PK
	idCarModel varchar (3) not null, --FK --> types_model(idCarModel)
	idColour varchar (3) not null, --FK --> types_colour(idColour)
	licensePlate varchar (7) not null, 
	totalkms integer not null, 
	datePurchase date not null,
	constraint cars_PK primary key (idCar),
	constraint cars_model_FK foreign key (idCarModel)
	references ana_jimenez_alfaro.types_model (idCarModel),
	constraint cars_colours_FK foreign key (idColour)
	references ana_jimenez_alfaro.types_colours (idColour),
	comments varchar(250) null
	
);

-- tabla historica de revisiones -- 
	
create table ana_jimenez_alfaro.hist_revision (
	idRevision varchar(9) not null, --PK
	idCar varchar (200) not null, --PK, FK --> cars(idCar)
	idCurrency varchar (3) not null, --FK --> types_currency(idCurrency)
	dateRevision date not null,
	kmsRevision integer not null,
	costRevision numeric (4) not null,
	constraint hist_revision_PK primary key (idRevision, idCar),
	constraint hist_revision_cars_FK foreign key (idCar)
	references ana_jimenez_alfaro.cars (idCar),
	constraint hist_revision_currency foreign key (idCurrency)
	references ana_jimenez_alfaro.types_currency (idCurrency),
	
	comments varchar (250)
);


	
-- tabla polizas seguros -- 

create table ana_jimenez_alfaro.insurance_policies (
	idPolicy varchar (5) not null, --PK
	idCar varchar (200) not null, --FK --> cars(idCar)
	idInsuranceCompany varchar (3) not null, --FK -->types_insurance_companies(idInsuranceCompany)
	idTypePolicy varchar (2) not null, --FK -->types_policies(idTypePolicy)
	nPolicy bigint not null,
	constraint insurance_policies_PK primary key (idPolicy),
	constraint insurance_policies_cars foreign key (idCar)
	references ana_jimenez_alfaro.cars (idCar),
	constraint insurance_policies_companies foreign key (idInsuranceCompany)
	references ana_jimenez_alfaro.types_insurance_companies (idInsuranceCompany),
	constraint insurance_policies_types foreign key (idTypePolicy)
	references ana_jimenez_alfaro.types_policies (idTypePolicy),
	comments varchar(250) null 

);

-----------
--- DML ---
-----------

-- incluimos datos en types_currency 

insert into ana_jimenez_alfaro.types_currency  (idCurrency, namecurrency) values('USD', 'Dolar Americano');
insert into ana_jimenez_alfaro.types_currency (idCurrency, namecurrency) values('EUR','Euro'); 
insert into ana_jimenez_alfaro.types_currency (idCurrency, namecurrency) values('GBP','Libra Esterlina');
insert into ana_jimenez_alfaro.types_currency (idCurrency, namecurrency) values('JPY','Yen Japonés' );
insert into ana_jimenez_alfaro.types_currency (idCurrency, namecurrency) values('AUD','Dolar Australiano'); 

-- incluimos datos de currency_exchange --  

insert into ana_jimenez_alfaro.currency_exchange (idCurrency, currencyexchange) values('USD', 0.9526); -- cambio dollar -euro
insert into ana_jimenez_alfaro.currency_exchange (idCurrency, currencyexchange) values('EUR',1); -- Euro - Euro
insert into ana_jimenez_alfaro.currency_exchange (idCurrency, currencyexchange) values('GBP',1.1619); --Libra esterlina - Euro
insert into ana_jimenez_alfaro.currency_exchange (idCurrency, currencyexchange) values('JPY',0.6972); -- Yen - Euro
insert into ana_jimenez_alfaro.currency_exchange (idCurrency, currencyexchange) values('AUD',0.6384); -- Dollar Australiano - Euro


-- incluimos datos en types_policies -- 

insert into ana_jimenez_alfaro.types_policies  (idtypepolicy, typepolicy) values('TR','todo riesgo'); 
insert into ana_jimenez_alfaro.types_policies  (idtypepolicy, typepolicy) values('TE','terceros'); 
insert into ana_jimenez_alfaro.types_policies  (idtypepolicy, typepolicy) values('TA','terceros ampliados');


-- incluimos datos en types_insurance_companies -- 

insert into ana_jimenez_alfaro.types_insurance_companies  (idinsurancecompany, insurancecompany, "comments" ) values('GEN','Generali Seguros',' '); 
insert into ana_jimenez_alfaro.types_insurance_companies  (idinsurancecompany, insurancecompany, "comments" ) values('ZUR','Zurich',' '); 
insert into ana_jimenez_alfaro.types_insurance_companies  (idinsurancecompany, insurancecompany, "comments" ) values('AXA','Axa',' '); 
insert into ana_jimenez_alfaro.types_insurance_companies  (idinsurancecompany, insurancecompany, "comments" ) values('MAP','Mapfre',' '); 
insert into ana_jimenez_alfaro.types_insurance_companies  (idinsurancecompany, insurancecompany, "comments" ) values('ALL','Allianz',' '); 
insert into ana_jimenez_alfaro.types_insurance_companies  (idinsurancecompany, insurancecompany, "comments" ) values('MUT','Mutua Madrileña',' '); 
insert into ana_jimenez_alfaro.types_insurance_companies  (idinsurancecompany, insurancecompany, "comments" ) values('VER','Verti',' '); 


-- incluimos datos en types_colours -- 

insert into ana_jimenez_alfaro.types_colours (idcolour, colour, "comments" ) values('001','Blanco',' '); 
insert into ana_jimenez_alfaro.types_colours (idcolour, colour, "comments" ) values('002','Negro',' '); 
insert into ana_jimenez_alfaro.types_colours (idcolour, colour, "comments" ) values('003','Gris',' '); 
insert into ana_jimenez_alfaro.types_colours (idcolour, colour, "comments" ) values('004','Rojo',' '); 
insert into ana_jimenez_alfaro.types_colours (idcolour, colour, "comments" ) values('005','Verde',' '); 
insert into ana_jimenez_alfaro.types_colours (idcolour, colour, "comments" ) values('006','Azul',' '); 


-- incluimos datos en types_car_company -- 

insert into ana_jimenez_alfaro.types_car_company (idCarCompany,carCompany,"comments") values ('CC01','VAN',' ');
insert into ana_jimenez_alfaro.types_car_company (idCarCompany,carCompany,"comments") values ('CC02','BMW Group',' ');
insert into ana_jimenez_alfaro.types_car_company (idCarCompany,carCompany,"comments") values ('CC03','Daimler',' ');
insert into ana_jimenez_alfaro.types_car_company (idCarCompany,carCompany,"comments") values ('CC04','PSA',' ');

-- incluimos datos en types_brand --

insert into ana_jimenez_alfaro.types_brand  (idCarBrand,idCarCompany,carBrand,"comments")values ('CB001','CC02','BMW',' ');
insert into ana_jimenez_alfaro.types_brand (idCarBrand,idCarCompany,carBrand,"comments")values ('CB002','CC02','MINI',' ');
insert into ana_jimenez_alfaro.types_brand (idCarBrand,idCarCompany,carBrand,"comments")values ('CB003','CC03','Smart',' ');
insert into ana_jimenez_alfaro.types_brand (idCarBrand,idCarCompany,carBrand,"comments")values ('CB004','CC04','Renault',' ');
insert into ana_jimenez_alfaro.types_brand (idCarBrand,idCarCompany,carBrand,"comments")values ('CB005','CC01','Volkswagen',' ');
insert into ana_jimenez_alfaro.types_brand (idCarBrand,idCarCompany,carBrand,"comments")values ('CB006','CC03','Mercedes-Benz',' ');
insert into ana_jimenez_alfaro.types_brand (idCarBrand,idCarCompany,carBrand,"comments")values ('CB007','CC01','Audi',' ');
insert into ana_jimenez_alfaro.types_brand (idCarBrand,idCarCompany,carBrand,"comments")values ('CB008','CC04','Peugeot',' ');
insert into ana_jimenez_alfaro.types_brand (idCarBrand,idCarCompany,carBrand,"comments")values ('CB009','CC01','SEAT',' ');
insert into ana_jimenez_alfaro.types_brand (idCarBrand,idCarCompany,carBrand,"comments")values ('CB010','CC02','Roll-Royce',' ');

-- incluimos datos en types_model -- 

insert into ana_jimenez_alfaro.types_model  (idCarModel,idCarBrand,carModel,"comments")values ('B01','CB001','BMW X3',' ');
insert into ana_jimenez_alfaro.types_model (idCarModel,idCarBrand,carModel,"comments")values ('B02','CB001','BMW Serie 1 118i',' ');
insert into ana_jimenez_alfaro.types_model (idCarModel,idCarBrand,carModel,"comments")values ('B03','CB002','MINI Cooper Countryman',' ');
insert into ana_jimenez_alfaro.types_model (idCarModel,idCarBrand,carModel,"comments")values ('D01','CB003','Smart #1 Pro+',' ');
insert into ana_jimenez_alfaro.types_model (idCarModel,idCarBrand,carModel,"comments")values ('V01','CB005','Volkswagen Polo',' ');
insert into ana_jimenez_alfaro.types_model (idCarModel,idCarBrand,carModel,"comments")values ('V02','CB005','Volkswagen Golf Life 2.0 TDI',' ');
insert into ana_jimenez_alfaro.types_model (idCarModel,idCarBrand,carModel,"comments")values ('P01','CB004','Renault Arkana Equilibre Tce',' ');
insert into ana_jimenez_alfaro.types_model (idCarModel,idCarBrand,carModel,"comments")values ('D02','CB006','Mercedes-Benz Clase C 200d Berlina',' ');
insert into ana_jimenez_alfaro.types_model (idCarModel,idCarBrand,carModel,"comments")values ('P02','CB004','Renault Grand Scenic Executive Tce',' ');
insert into ana_jimenez_alfaro.types_model (idCarModel,idCarBrand,carModel,"comments")values ('D03','CB006','Mercedes-Benz CLA 200 CDI',' ');
insert into ana_jimenez_alfaro.types_model (idCarModel,idCarBrand,carModel,"comments")values ('V03','CB007','Audi A1 Sportback Advanced 25 TFSI',' ');
insert into ana_jimenez_alfaro.types_model (idCarModel,idCarBrand,carModel,"comments")values ('P03','CB008','Peugeout 5008 Active Pack PureTech 130 S&S',' ');


-- incluimos datos en cars 

insert into ana_jimenez_alfaro.cars (idcar,idcarmodel,idcolour,licensePlate,totalkms,datePurchase,"comments")values ('001','B02','001','7394HLK',3099,'12/28/21',' ');
insert into ana_jimenez_alfaro.cars (idcar,idcarmodel,idcolour,licensePlate,totalkms,datePurchase,"comments")values ('002','B03','004','7238LMI',5740,'10/31/22',' ');
insert into ana_jimenez_alfaro.cars (idcar,idcarmodel,idcolour,licensePlate,totalkms,datePurchase,"comments")values ('003','V02','006','0098LHY',51676,'04/17/17',' ');
insert into ana_jimenez_alfaro.cars (idcar,idcarmodel,idcolour,licensePlate,totalkms,datePurchase,"comments")values ('004','P01','006','6538JYL',62413,'02/23/16',' ');
insert into ana_jimenez_alfaro.cars (idcar,idcarmodel,idcolour,licensePlate,totalkms,datePurchase,"comments")values ('005','D02','002','8950OPL',73150,'10/25/15',' ');
insert into ana_jimenez_alfaro.cars (idcar,idcarmodel,idcolour,licensePlate,totalkms,datePurchase,"comments")values ('006','P03','002','0001KLM',116097,'06/06/11',' ');

-- incluimos datos en el historico de revisiones 


insert into ana_jimenez_alfaro.hist_revision (idRevision,idCar,idcurrency,dateRevision,kmsRevision,costRevision,"comments")values ('R-003-001','003','EUR','08/30/18',15978,50,'Revision primeros 15km ');
insert into ana_jimenez_alfaro.hist_revision (idRevision,idCar,idcurrency,dateRevision,kmsRevision,costRevision,"comments")values ('R-003-002','003','EUR','12/01/20',30978,100,'Segunda revision');
insert into ana_jimenez_alfaro.hist_revision (idRevision,idCar,idcurrency,dateRevision,kmsRevision,costRevision,"comments")values ('R-003-003','003','EUR','05/26/22',45978,67.8,'tercera revision ');
insert into ana_jimenez_alfaro.hist_revision (idRevision,idCar,idcurrency,dateRevision,kmsRevision,costRevision,"comments")values ('R-004-001','004','JPY','07/07/17',16789,70,'Revision primeros 15km ');
insert into ana_jimenez_alfaro.hist_revision (idRevision,idCar,idcurrency,dateRevision,kmsRevision,costRevision,"comments")values ('R-004-002','004','JPY','11/19/18',31789,80,'Segunda revision');
insert into ana_jimenez_alfaro.hist_revision (idRevision,idCar,idcurrency,dateRevision,kmsRevision,costRevision,"comments")values ('R-004-003','004','JPY','04/02/20',46789,10,'tercera revision ');
insert into ana_jimenez_alfaro.hist_revision (idRevision,idCar,idcurrency,dateRevision,kmsRevision,costRevision,"comments")values ('R-004-004','004','JPY','08/15/21',61789,100,'Cuarta revision 60.000 km');
insert into ana_jimenez_alfaro.hist_revision (idRevision,idCar,idcurrency,dateRevision,kmsRevision,costRevision,"comments")values ('R-005-001','005','GBP','03/08/17',14998,25,'Revision primeros 15km ');
insert into ana_jimenez_alfaro.hist_revision (idRevision,idCar,idcurrency,dateRevision,kmsRevision,costRevision,"comments")values ('R-005-002','005','GBP','07/21/18',29998,100,'Segunda revision');
insert into ana_jimenez_alfaro.hist_revision (idRevision,idCar,idcurrency,dateRevision,kmsRevision,costRevision,"comments")values ('R-005-003','005','GBP','12/03/19',44998,100,'tercera revision ');
insert into ana_jimenez_alfaro.hist_revision (idRevision,idCar,idcurrency,dateRevision,kmsRevision,costRevision,"comments")values ('R-005-004','005','GBP','04/16/21',59998,300,'Cuarta revision 60.000 km');
insert into ana_jimenez_alfaro.hist_revision (idRevision,idCar,idcurrency,dateRevision,kmsRevision,costRevision,"comments")values ('R-006-001','006','USD','10/18/12',15694,10,'Revision primeros 15km ');
insert into ana_jimenez_alfaro.hist_revision (idRevision,idCar,idcurrency,dateRevision,kmsRevision,costRevision,"comments")values ('R-006-002','006','USD','03/02/14',30694,10,'Segunda revision');
insert into ana_jimenez_alfaro.hist_revision (idRevision,idCar,idcurrency,dateRevision,kmsRevision,costRevision,"comments")values ('R-006-003','006','USD','07/15/15',45694,50,'tercera revision ');
insert into ana_jimenez_alfaro.hist_revision (idRevision,idCar,idcurrency,dateRevision,kmsRevision,costRevision,"comments")values ('R-006-004','006','USD','11/26/16',60694,60,'Cuarta revision 60.000 km');
insert into ana_jimenez_alfaro.hist_revision (idRevision,idCar,idcurrency,dateRevision,kmsRevision,costRevision,"comments")values ('R-006-005','006','USD','04/10/18',75694,80,'Revisión 75.000 km');
insert into ana_jimenez_alfaro.hist_revision (idRevision,idCar,idcurrency,dateRevision,kmsRevision,costRevision,"comments")values ('R-006-006','006','USD','08/23/19',90694,100,'Revisión 90.000 km ');
insert into ana_jimenez_alfaro.hist_revision (idRevision,idCar,idcurrency,dateRevision,kmsRevision,costRevision,"comments")values ('R-006-007','006','USD','01/04/22',105694,300,'Revisión 105.000 km');



-- si lo deseamos podemos ver todas las cantidades convertidas a euros
-- cambio consultado el 1 de Diciembre de 2022

select  a.idrevision, a.idcar, a.idcurrency, a.daterevision, a.kmsrevision, a.costRevision, a."comments",
a.costrevision * b.currencyexchange as costrevisioneuros 
from ana_jimenez_alfaro.hist_revision a 
left join ana_jimenez_alfaro.currency_exchange b
on a.idcurrency  = b.idcurrency --funciona
;


-- incluimos datos en las polizas de seguros 

insert into ana_jimenez_alfaro.insurance_policies (idPolicy,idCar,idinsurancecompany,idtypepolicy,nPolicy,"comments")values ('G001','001','GEN','TR',9106378591,' ');
insert into ana_jimenez_alfaro.insurance_policies (idPolicy,idCar,idinsurancecompany,idtypepolicy,nPolicy,"comments")values ('Z001','002','ZUR','TE', 1174872690,' ');
insert into ana_jimenez_alfaro.insurance_policies (idPolicy,idCar,idinsurancecompany,idtypepolicy,nPolicy,"comments")values ('AX001','003','AXA','TA',2201837169,' ');
insert into ana_jimenez_alfaro.insurance_policies (idPolicy,idCar,idinsurancecompany,idtypepolicy,nPolicy,"comments")values ('G002','004','GEN','TR',9106378950,' ');
insert into ana_jimenez_alfaro.insurance_policies (idPolicy,idCar,idinsurancecompany,idtypepolicy,nPolicy,"comments")values ('M001','005','MAP','TE',8897462639,' ');
insert into ana_jimenez_alfaro.insurance_policies (idPolicy,idCar,idinsurancecompany,idtypepolicy,nPolicy,"comments")values ('A001','006','ALL','TR',7894827689,' ');






