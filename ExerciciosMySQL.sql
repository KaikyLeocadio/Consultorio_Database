create database Db_Consultorio; /* Cria a DataBase */
use Db_Consultorio; /* Seleciona a DataBase */

/* Exlui alguma parte da DataBase */
drop database db_consultorio;

/* Delete exclui os dados de determinada tabela */

/* Cria uma tabela com os atributos */
create table Tb_Paciente(
Id_Paciente int auto_increment not null,
Nome_Paciente varchar(100) not null,
Data_Nascimento_Paciente date not null,
Genero_Paciente enum('M' , 'F' , 'T' , 'nao-binario') not null,
Cpf_Paciente varchar(14) not null,
constraint Pk_Id_Paciente primary key (Id_Paciente)
);

/* Cria uma tabela com os atributos */
create table tb_Medico(
Id_Medico int auto_increment not null,
Nome_Medico varchar (100) not null,
Data_Nascimento_Medico date not null,
Crm_Medico varchar (13) not null,
Genero_Medico enum ('M' , 'F' , 'T' , 'nao-binario'),
Cpf_Medico varchar (14) not null, 
Especialidade_Medico varchar (30) not null,
Turno_Medico enum ('manha','tarde','noite','madrugada') not null,
Contato_Medico varchar (15) not null,
constraint Pk_Id_Medico primary key (Id_Medico)
);

create table tb_Consulta(
	Id_Consulta int not null auto_increment,
	Data_Consulta date not null,
    Hora_Consulta time not null, /* Timestamp puxa a data da hora no sistema */
    Fk_Id_Medico int not null,
    Fk_Id_Paciente int not null,
    
    constraint Pk_Id_Consulta primary key (Id_Consulta), /* Constraint define o que é PK e FK */
    
    constraint Fk_Id_Medico foreign key (Fk_Id_Medico)
    references tb_Medico (Id_Medico), /* Referencia de onde estamos puxando os dados */
    
    constraint Fk_Id_Paciente foreign key (Fk_Id_Paciente)
    references tb_Paciente (Id_Paciente)
);

/* Cria a tabela Receita com os atributos */
create table tb_Receita(
    Pk_Id_Receita int auto_increment not null primary key,
    Fk_Id_Consulta int not null,
    Fk_Id_Paciente int not null,
    Fk_Id_Medico int not null,
    Prescricao varchar(255) not null,
    Data_Receita date not null,
    CID varchar(10) not null,
    constraint Fk_Receita_Consulta foreign key (Fk_Id_Consulta) references tb_Consulta (Id_Consulta),
    constraint Fk_Receita_Paciente foreign key (Fk_Id_Paciente) references Tb_Paciente (Id_Paciente),
    constraint Fk_Receita_Medico foreign key (Fk_Id_Medico) references tb_Medico (Id_Medico)
);

/* Cria a tabela Agendamento com os atributos */
create table tb_Agendamento(
    Pk_Id_Agendamento int auto_increment not null primary key,
    Fk_Id_Medico int not null,
    Fk_Id_Paciente int not null,
    Horario_do_Agendamento time not null,
    Data_do_Agendamento date not null,
    constraint Fk_Agendamento_Medico foreign key (Fk_Id_Medico) references tb_Medico (Id_Medico),
    constraint Fk_Agendamento_Paciente foreign key (Fk_Id_Paciente) references Tb_Paciente (Id_Paciente)
);

/* Cria a tabela Funcionario com os atributos */
create table tb_Funcionario(
    Pk_Id_Funcionario int auto_increment not null primary key,
    Nome_Funcionario varchar(100) not null,
    Cargo varchar(50) not null,
    Data_Nascimento_Funcionario date not null
);


describe tb_Paciente; /* Mostra quais são os campos da tabela */
describe tb_Medico; /* Mostra quais são os campos da tabela */
describe tb_Consulta; /* Mostra quais são os campos da tabela */

insert into tb_Consulta (Data_Consulta, Hora_Consulta, Fk_Id_Medico, Fk_Id_Paciente) values
('2024/02/12', '15:00:00', 1, 1),
('2024/03/27', '16:00:00', 2, 2),
('2024/12/23', '11:00:00', 3, 3),
('2024/06/02', '10:00:00', 4, 4);
/* Insere dados nos campos da tabela */

insert into tb_Medico (Nome_Medico, Data_Nascimento_Medico, Crm_Medico, Genero_Medico, Cpf_Medico, Especialidade_Medico, Turno_Medico, Contato_Medico) values 
('Alicia Rodrigues','1941/04/20','CRM/SP 555555','f', '999.999.999-99', 'Ginecologista', 'manha', '11987974578'),
('Francisco Dantas ', '1975/11/21','CRM/RJ 777777','m', '222.222.222-22', 'Fisioterapeuta', 'tarde', '11987974555'),
('Robyn Rihanna Fenty ','1941/04/20','CRM/GO 222333','f', '999.999.999-99', 'Ginicologista', 'noite', '11987974333'),
('Shaffer Chimere Smith', '1941/04/20','CRM/MT 111666','f', '999.999.999-99', 'Ginicologista', 'madrugada', '11117974111');
/* Insere dados nos campos da tabela */

insert into tb_Paciente (Nome_Paciente, Data_Nascimento_Paciente, Genero_Paciente, Cpf_Paciente) values
('Roberta Carla', '2004/04/18', 'f', '999.999.999-99'),
('Conde Dracula', '1666/04/20', 'f', '666.666.666-66'),
('Saul Hudson', '1952/09/21', 'm', '982.912.852-33'),
('William Bayley', '1952/07/04', 'm', '123.321.789-79'),
('Massimiliano Cavalera', '1970/02/19', 'm', '654.321.987-21'),
('Yoko Ono', '1920/11/06', 'f', '444.556.926-35');
/* Insere dados nos campos da tabela */

select * from tb_Paciente; /* Exibe os dados inseridos na tabela */
select * from tb_Medico; /* Exibe os dados inseridos na tabela */
select * from tb_Consulta; /* Exibe os dados inseridos na tabela */

/* Usando o JOIN */
select * from tb_Consulta as c /* as = alias, apelido / C de consulta / exibir tudo da tabela */
join tb_Paciente as p /* join = junto / juntando (unindo) a tabela consulta com paciente */
on c.id_Consulta = p.id_Paciente; /* on = onde, ligação / onde a ligação será pelo ID das duas tabelas /
/* Aqui ele junta as duas tabelas e da um match entre os dados da consulta e paciente pelo ID, como um rasteamento */

/* Mostra somente os dados selecionados de diversas tabelas */
select c.Data_Consulta, p.Nome_Paciente, m.Nome_Medico from tb_Consulta as c
join tb_Paciente as p
on c.id_Consulta = p.id_Paciente
join tb_Medico as m
on c.id_Consulta = m.id_Medico;

/* Adicionando o order by, ele faz os nomes dos pacientes ficarem em ordem alfabetica */
select c.Data_Consulta, p.Nome_Paciente, m.Nome_Medico from tb_Consulta as c
join tb_Paciente as p
on c.id_Consulta = p.id_Paciente
join tb_Medico as m
on c.id_Consulta = m.id_Medico
order by p.Nome_Paciente;

/* Usando o INNER JOIN */
select * from tb_Consulta as c
join tb_Paciente as p
on c.id_Consulta = p.id_Paciente
join tb_Medico as m
on c.id_Consulta = m.id_Medico;

/* TRABALHANDO COM DELETE */
DELETE FROM tb_Consulta
WHERE Fk_Id_Medico = 1;

select * from tb_Consulta;

select Nome_Paciente , Data_Nascimento_Paciente from tb_Paciente; /* Exibe dados SELECIONADOS */

alter table tb_Paciente /* Atua na estrutura da tabela */
add column Convenio_Paciente varchar(35);

update tb_Paciente /* Atua na atualização dos dados da tabela*/
set Convenio_Paciente = 'Sírio Libanês' /* set = selecionando */
where Nome_Paciente = 'Roberta Carla'; /* colocar o nome do convenio ONDE/WHERE nome do paciente for = X */

select * from tb_Paciente;

update tb_Paciente
set Convenio_Paciente = 'Porto Seguro'
where Id_Paciente in (1, 2); /* In é listado, seleciona e bota dentro de todos numeros que forem definidos*/	