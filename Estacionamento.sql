CREATE DATABASE Estacionamento;
USE Estacionamento;

CREATE TABLE if not exists cliente(
	cpf_cli int not null auto_increment,
    nome_cli varchar(60) not null,
    nascimento_cli date not null,
    primary key(cpf_cli)
    );
    
CREATE TABLE if not exists modelo(
	cod_mod int not null auto_increment,
	desc_mod varchar(40),
	primary key(cod_mod)
);

CREATE TABLE if not exists patio(
	num_pat int not null auto_increment,
    endereco_pat varchar(40),
    capacidade int,
	primary key(num_pat)
);

CREATE TABLE if not exists veiculo(
	placa_vei varchar(8) not null,
    modelo_cod_vei int not null,
    cliente_cpf_vei int not null,
    cor_vei varchar(20),
	primary key(placa_vei,modelo_cod_vei,cliente_cpf_vei),
    CONSTRAINT vei_fk1 FOREIGN KEY (modelo_cod_vei)
    REFERENCES modelo(cod_mod)
    ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT vei_fk2 FOREIGN KEY (cliente_cpf_vei)
    REFERENCES cliente(cpf_cli)
    ON DELETE CASCADE ON UPDATE CASCADE   
);

CREATE TABLE if not exists estaciona(
	cod_est int not null auto_increment,
    patio_num_est int not null,
    placa_vei_est varchar(8),
    dtEntrada_est varchar(10),
    dtSaida_est varchar(10),
    hsEntrada_est varchar(10),
    hsSaida_est varchar(10),
	primary key(cod_est,patio_num_est,placa_vei_est),
	CONSTRAINT est_fk1 FOREIGN KEY (patio_num_est)
    REFERENCES patio(num_pat)
    ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT est_fk2 FOREIGN KEY (placa_vei_est)
    REFERENCES veiculo(placa_vei)
    ON DELETE CASCADE ON UPDATE CASCADE   
);

-- fim da criação das tabelas;
INSERT INTO cliente (nome_cli,nascimento_cli) values
	('Maria','1980-05-04'),
	('José','1990-10-20'),
	('João','1968-07-05'),
	('Carla','2001-10-10');

INSERT INTO modelo (desc_mod) values
	('Chevrolet Traker'),
    ('Volkswagem  Polo'),
    ('Hyndai Creta'),
    ('Nissan Kics');

INSERT INTO veiculo (placa_vei,modelo_cod_vei,cliente_cpf_vei,cor_vei) values
	('FFF-3030',1,4,'verde'),
	('III-4040',2,3,'prata'),
	('JJJ-2020',3,2,'cinza'),
	('JEG-1010',4,1,'preto');


INSERT INTO patio (endereco_pat,capacidade) values
	('Rua do Porto',10),
	('São Dimas',20),
	('Centro',30);

INSERT INTO estaciona (patio_num_est, placa_vei_est, dtEntrada_est, dtSaida_est, hsEntrada_est, hsSaida_est) values
	(1,'FFF-3030','06/11/2023','06/11/2023','09:00','13:00'),
	(2,'JJJ-2020','06/11/2023','06/11/2023','09:00','12:00'),
	(3,'JEG-1010','06/11/2023','06/11/2023','10:00','11:00'),
	(1,'FFF-3030','06/11/2023','07/11/2023','10:00','14:00'),
	(2,'JJJ-2020','07/11/2023','07/11/2023','08:00','16:00'),
	(3,'JJJ-2020','07/11/2023','07/11/2023','09:00','15:00'),
	(1,'JJJ-2020','07/11/2023','08/11/2023','10:00','15:00'),
	(2,'JJJ-2020','08/11/2023','08/11/2023','10:00','14:00'),
	(1,'JEG-1010','08/11/2023','08/11/2023','11:00','13:00'),
	(2,'JEG-1010','09/11/2023','09/11/2023','11:00','12:00');

-- fim da inserção de dados

-- a) Exiba a placa e o nome dos donos de todos os veículos.
SELECT 	vei.placa_vei as placa,
		cli.nome_cli as nome 
from veiculo as vei left outer join cliente as cli 
on vei.cliente_cpf_vei = cli.cpf_cli;

-- b) Exiba o CPF e o nome do cliente que possui o veículo de placa “JJJ-2020”.
SELECT c.cpf_cli as cpf,
	   c.nome_cli as nome
from cliente as c inner join veiculo as v
on  v.cliente_cpf_vei = c.cpf_cli
where v.placa_vei = 'JJJ-2020';

-- c) Exiba a placa e a cor do veículo que possui o código de estacionamento 1.
-- d) Exiba a placa e o cor do veículo que possui o código de estacionamento 1.
SELECT v.placa_vei as placa,
	   v.cor_vei as cor
from veiculo as v inner join estaciona as e
on  e.placa_vei_est = v.placa_vei
where e.cod_est = 1;

-- e) Exiba a placa, o cor do do veículo e a descrição de seu modelo, se ele possuir no proprietários nascidos  a partir de 2000.
SELECT v.placa_vei as placa,
	   v.cor_vei as cor,
       m.desc_mod as descricao
from veiculo as v inner join modelo as m
on v.modelo_cod_vei = m.cod_mod
inner join cliente as c on c.cpf_cli = v.cliente_cpf_vei
 where c.nascimento_cli >= '2000-01-01';
 
-- f) Exiba o endereço, a data de entrada e de saída dos estacionamentos do veículo de placa “JEG-1010”.
SELECT p.endereco_pat as endereco,
		e.dtEntrada_est as entrada,
		e.dtSaida_est as saida
from estaciona as e inner join patio as p
on p.num_pat = e.patio_num_est
inner join veiculo as v on e.placa_vei_est = v.placa_vei
where v.placa_vei = 'JEG-1010';

-- g) Exiba a quantidade de vezes que os veículos de cor verde estacionaram.
SELECT count(*) as Vezes from estaciona as e 
join veiculo as v 
on v.placa_vei = e.placa_vei_est
where v.cor_vei = 'verde';

-- h) Liste todos os clientes que possuem carro de modelo 1.
Select c.* from cliente as c inner join veiculo as v 
on v.cliente_cpf_vei = c.cpf_cli inner join modelo as m
on v.modelo_cod_vei = m.cod_mod 
where m.cod_mod = 1;

-- i) Liste as placas, os horários de entrada e saída dos veículos de cor verde.
SELECT v.placa_vei as placa ,
	   e.hsEntrada_est as entrada,
       e.hsSaida_est as saida
       from estaciona as e 
join veiculo as v on v.placa_vei = e.placa_vei_est
where v.cor_vei = 'verde';

-- j) Liste todos os estacionamentos do veículo de placa “JJJ-2020”.
SELECT e.*  from estaciona as e
join veiculo as v on v.placa_vei = e.placa_vei_est
where v.placa_vei = 'JJJ-2020';

-- k) Exiba o nome do cliente que possui o veículo cujo código do estacionamento é 2.
Select c.nome_cli as nome from cliente as c inner join veiculo as v 
on v.cliente_cpf_vei = c.cpf_cli inner join estaciona as e
on v.placa_vei = e.placa_vei_est 
where e.cod_est = 2;

-- l) Exiba o CPF do cliente que possui o veículo cujo código do estacionamento é 3.
Select c.cpf_cli as cpf from cliente as c inner join veiculo as v 
on v.cliente_cpf_vei = c.cpf_cli inner join estaciona as e
on v.placa_vei = e.placa_vei_est 
where e.cod_est = 3;

-- m) Exiba a descrição do modelo do veículo cujo código do estacionamento é 2.
Select m.desc_mod as descricao from modelo as m inner join veiculo as v 
on m.cod_mod = v.modelo_cod_vei inner join estaciona as e
on v.placa_vei = e.placa_vei_est 
where e.cod_est = 2;

-- n) Exiba a placa, o nome dos donos e a descrição dos os modelos de todos os veículos.
SELECT v.placa_vei as placa, c.nome_cli as nome, m.desc_mod as descricao from veiculo as v 
join cliente as c on v.cliente_cpf_vei = c.cpf_cli 
join modelo as m on m.cod_mod = v.modelo_cod_vei;
 

