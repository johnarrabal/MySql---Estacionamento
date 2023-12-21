1)	Implemente o modelo abaixo no banco de dados MySql.
a. Tabela Cliente
  - CPF (INT) (PK)
  - NOME (VARCHAR)
  - DATA DE NASCIMENTO (DATE)
b. Tabela Modelo
  - CODMOD (INT)(PK)
  - DESC_2(VARCHAR)
c. Patio
  - NUM (INT)(PK)
  - ENDER (VARCHAR)
  - CAPACIDADE (INT)
c. Veiculo
  - PLACA (VARCHAR)
  - MODELO_CODMOD (FK)
  - CLIENTE_CPF (FK)
  - COR (VARCHAR)
d. Estaciona
  - COD (INT)(PK)
  - PATIO_NUM (INT)(FK)
  - VEICULO_PLACA (VARCHAR)(FK)
  - DTENTRADA (VARCHAR)
  - DTSAIDA (VARCHAR)
  - HSENTRADA (VARCHAR)
  - HSSAIDA (VARCHAR)

2) Logo após inseri dados na tabela
3) Implemente as consultas abaixo considerando o modelo conceitual acima e utilizando para realizar a junção SOMENTE os comandos INNER JOIN, LEFT OUTER JOIN ou RIGHT OUTER JOIN.
a) Exiba a placa e o nome dos donos de todos os veículos.
b) Exiba o CPF e o nome do cliente que possui o veículo de placa “JJJ-2020”.
c) Exiba a placa e a cor do veículo que possui o código de estacionamento 1.
d) Exiba a placa e o cor do veículo que possui o código de estacionamento 1.
e) Exiba a placa, o cor do do veículo e a descrição de seu modelo, se ele possuir no proprietários nascidos  a partir de 2000.
f) Exiba o endereço, a data de entrada e de saída dos estacionamentos do veículo de placa “JEG-1010”.
g) Exiba a quantidade de vezes que os veículos de cor verde estacionaram.
h) Liste todos os clientes que possuem carro de modelo 1.
i) Liste as placas, os horários de entrada e saída dos veículos de cor verde.
j) Liste todos os estacionamentos do veículo de placa “JJJ-2020”.
k) Exiba o nome do cliente que possui o veículo cujo código do estacionamento é 2.
l) Exiba o CPF do cliente que possui o veículo cujo código do estacionamento é 3.
m) Exiba a descrição do modelo do veículo cujo código do estacionamento é 2.
n) Exiba a placa, o nome dos donos e a descrição dos os modelos de todos os veículos.
