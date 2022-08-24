/* RELATORIO GERAL DE TODOS OS CLIENTES */
	SELECT * FROM CLIENTE C
	INNER JOIN TELEFONE T
	ON C.IDCLIENTE = T.ID_CLIENTE
	INNER JOIN ENDERECO E
	ON C.IDCLIENTE = E.ID_CLIENTE; 
	
	---------------------------------------------------------
	
	SELECT C.NOME, C.SEXO, C.EMAIL, E.CIDADE, E.ESTADO, E.BAIRRO, T.NUMERO, C.CPF FROM CLIENTE C
	INNER JOIN TELEFONE T
	ON C.IDCLIENTE = T.ID_CLIENTE
	INNER JOIN ENDERECO E
	ON C.IDCLIENTE = E.ID_CLIENTE
	ORDER BY SEXO;
	
/* RELATORIO - SOMENTE HOMENS */
	SELECT C.NOME, C.SEXO, C.EMAIL, C.CPF, E.CIDADE, E.BAIRRO, E.CIDADE, T.NUMERO, T.TIPO FROM CLIENTE C
	INNER JOIN TELEFONE T
	ON C.IDCLIENTE = T.ID_CLIENTE
	INNER JOIN ENDERECO E
	ON C.IDCLIENTE = E.ID_CLIENTE
	WHERE C.SEXO = "M";
/* RELATORIO - SOMENTE MULHERES */
	SELECT C.NOME, C.SEXO, C.EMAIL, C.CPF, E.CIDADE, E.BAIRRO, E.CIDADE, T.NUMERO, T.TIPO FROM CLIENTE C
	INNER JOIN TELEFONE T
	ON C.IDCLIENTE = T.ID_CLIENTE
	INNER JOIN ENDERECO E
	ON C.IDCLIENTE = E.ID_CLIENTE
	WHERE C.SEXO = 'F';
/* QUANTIDADE DE HOMENS E MULHERES*/
	SELECT SEXO,
	COUNT(*) AS QTD_SEXO_F,
	COUNT(*) AS QTD_SEXO_M
	FROM CLIENTE
	GROUP BY SEXO;
	--> MELHORANDO UM POUCO:
	SELECT SEXO,
	COUNT(*) AS QTD	
	FROM CLIENTE
	GROUP BY SEXO;
/* IDS E EMAILS DAS MULHERES QUE MORAM NO CENTRO DO RJ E NÃO TEM CELULAR*/
	SELECT CLI.IDCLIENTE, CLI.EMAIL, LOC.CIDADE, LOC.ESTADO, TEL.TIPO FROM CLIENTE CLI
	INNER JOIN TELEFONE TEL
	ON CLI.IDCLIENTE = TEL.ID_CLIENTE
	INNER JOIN ENDERECO LOC
	ON CLI.IDCLIENTE = LOC.ID_CLIENTE
	WHERE  NOT TEL.TIPO='CEL' AND CLI.SEXO ='F' AND LOC.CIDADE='RIO DE JANEIRO';
/* RELATORIO GERAL DE TODOS OS CLIENTES (TELEFONE E ENDERECO) */
	SELECT C.NOME, TEL.TIPO, TEL.NUMERO, LOC.CIDADE, LOC.BAIRRO, LOC.ESTADO FROM CLIENTE C
	INNER JOIN TELEFONE TEL
	ON C.IDCLIENTE = TEL.ID_CLIENTE
	INNER JOIN ENDERECO LOC
	ON C.IDCLIENTE = LOC.ID_CLIENTE;

--> ATUALIZANDO CLIENTE PARA CEL = NULL
SELECT ID_CLIENTE FROM TELEFONE
WHERE ID_CLIENTE = '3'; 

UPDATE TELEFONE 
SET NUMERO ='' 
WHERE ID_CLIENTE=3;

DESC CLIENTE;
DESC ENDERECO;
DESC TELEFONE;

--> CORREÇÃO DOS EXERCÍCIOS

--> NA PRIMEIRA QUESTÃO, NÃO ERA PARA TRAZER TODOS OS ELEMENTOS COM O *, POIS ISSO NÃO SE FAZ PROFISSIONALMENTE.

--> INICIAMOS COM O DESC DE CADA TABELA PARA ESCOLHERMOS OS QUE DESEJAMOS PROJETAR

/* RELATORIO GERAL DE TODOS OS CLIENTES */

DESC CLIENTE;
DESC ENDERECO;
DESC TELEFONE;
 DESC CLIENTE;
+-----------+---------------+------+-----+---------+----------------+
| Field     | Type          | Null | Key | Default | Extra          |
+-----------+---------------+------+-----+---------+----------------+
| IDCLIENTE | int(11)       | NO   | PRI | NULL    | auto_increment |
| NOME      | varchar(30)   | NO   |     | NULL    |                |
| SEXO      | enum('M','F') | NO   |     | NULL    |                |
| EMAIL     | varchar(50)   | YES  | UNI | NULL    |                |
| CPF       | varchar(15)   | YES  | UNI | NULL    |                |
+-----------+---------------+------+-----+---------+----------------+
5 rows in set (0.00 sec)

mysql> DESC ENDERECO;
+------------+-------------+------+-----+---------+----------------+
| Field      | Type        | Null | Key | Default | Extra          |
+------------+-------------+------+-----+---------+----------------+
| IDENDERECO | int(11)     | NO   | PRI | NULL    | auto_increment |
| RUA        | varchar(30) | NO   |     | NULL    |                |
| BAIRRO     | varchar(30) | NO   |     | NULL    |                |
| CIDADE     | varchar(30) | NO   |     | NULL    |                |
| ESTADO     | char(2)     | NO   |     | NULL    |                |
| ID_CLIENTE | int(11)     | YES  | UNI | NULL    |                |
+------------+-------------+------+-----+---------+----------------+
6 rows in set (0.00 sec)

mysql> DESC TELEFONE;
+------------+-------------------------+------+-----+---------+----------------+
| Field      | Type                    | Null | Key | Default | Extra          |
+------------+-------------------------+------+-----+---------+----------------+
| IDTELEFONE | int(11)                 | NO   | PRI | NULL    | auto_increment |
| TIPO       | enum('RES','COM','CEL') | NO   |     | NULL    |                |
| NUMERO     | varchar(10)             | NO   |     | NULL    |                |
| ID_CLIENTE | int(11)                 | YES  | MUL | NULL    |                |
+------------+-------------------------+------+-----+---------+----------------+
4 rows in set (0.00 sec)

SELECT C.IDCLIENTE, C.NOME, C.SEXO, C.EMAIL, C.CPF, 
	   E.CIDADE, E.BAIRRO, E.ESTADO, 
	   T.TIPO, T.NUMERO
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE;

--> A PARTIR DESTE RELATÓRIO DEVEMOS ATUALIZAR O SEXO QUE ESTIVER ERRADO

--> ANTES DE FAZER UM UPDATE, DEVEMOS PROJETAR COM O SELECT

SELECT * FROM CLIENTE
WHERE SEXO = 'M';

--> DESCOBRIMOS OS IDS QUE ESTÃO ERRADOS: 6, 7, 12, 13, 18, 19

SELECT * FROM CLIENTE
WHERE IDCLIENTE IN(6, 7, 12, 13, 18, 19);

UPDATE CLIENTE SET SEXO = 'F'
WHERE IDCLIENTE IN (6, 7, 12, 13, 18, 19);

/* RELATORIO - SOMENTE HOMENS */

SELECT C.IDCLIENTE, C.NOME, C.SEXO, C.EMAIL, C.CPF, 
	   E.CIDADE, E.BAIRRO, E.ESTADO, 
	   T.TIPO, T.NUMERO
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
WHERE C.SEXO = 'M';

/* RELATORIO - SOMENTE MULHERES */

SELECT C.IDCLIENTE, C.NOME, C.SEXO, C.EMAIL, C.CPF, 
	   E.CIDADE, E.BAIRRO, E.ESTADO, 
	   T.TIPO, T.NUMERO
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
WHERE C.SEXO = 'F';

/* IDS E EMAILS DAS MULHERES QUE MORAM NO CENTRO DO RJ E NÃO TEM CELULAR*/

SELECT C.NOME, C.SEXO, C.EMAIL, E.BAIRRO, E.CIDADE, T.TIPO, T.NUMERO
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
WHERE C.SEXO = "F" AND E.BAIRRO = "CENTRO" AND E.CIDADE = "RIO DE JANEIRO" AND NOT T.TIPO="CEL";


--> NOÇÕES SOBRE FUNÇÕES - IFNULL(COLUNA, 'RETORNO')

--> NESTE EXEMPLO BUSCAREMOS ALGUMAS INFORMAÇÕES, FOCANDO NA COLUNA EMAIL QUE COMTÉM NULL

SELECT C.NOME, C.EMAIL, E.ESTADO, T.NUMERO
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE;

+---------+-------------------+--------+----------+
| NOME    | EMAIL             | ESTADO | NUMERO   |
+---------+-------------------+--------+----------+
| JORGE   | JORGE@IG.COM      | ES     | 78458743 |
| JORGE   | JORGE@IG.COM      | ES     | 56576876 |
| JOAO    | JOAOA@IG.COM      | RJ     | 87866896 |
| CARLOS  | CARLOSA@IG.COM    | RJ     | 54768899 |
| JOAO    | JOAOA@IG.COM      | RJ     | 99667587 |
| ANA     | ANA@IG.COM        | SP     |          |
| ANA     | ANA@IG.COM        | SP     |          |
| JOAO    | JOAOA@IG.COM      | RJ     | 66687899 |
| JORGE   | JORGE@IG.COM      | ES     | 89986668 |
| CARLOS  | CARLOSA@IG.COM    | RJ     | 88687909 |
| FLAVIO  | FLAVIO@IG.COM     | MG     | 68976565 |
| FLAVIO  | FLAVIO@IG.COM     | MG     | 99656675 |
| GIOVANA | NULL              | RJ     | 33567765 |
| GIOVANA | NULL              | RJ     | 88668786 |
| GIOVANA | NULL              | RJ     | 55689654 |
| KARLA   | KARLA@GMAIL.COM   | RJ     | 88687979 |
| DANIELE | DANIELE@GMAIL.COM | ES     | 88965676 |
| EDUARDO | NULL              | PR     | 89966809 |
| ANTONIO | ANTONIO@IG.COM    | SP     | 88679978 |
| ANTONIO | ANTONIO@UOL.COM   | PR     | 99655768 |
| ELAINE  | ELAINE@GLOBO.COM  | SP     | 89955665 |
| CARMEM  | CARMEM@IG.COM     | RJ     | 77455786 |
| CARMEM  | CARMEM@IG.COM     | RJ     | 89766554 |
| ADRIANA | ADRIANA@GMAIL.COM | RJ     | 77755785 |
| ADRIANA | ADRIANA@GMAIL.COM | RJ     | 44522578 |
+---------+-------------------+--------+----------+

SELECT  C.NOME, 
		IFNULL(C.EMAIL,'************'), 
		E.ESTADO, 
		T.NUMERO
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE;

+---------+--------------------------------+--------+----------+
| NOME    | IFNULL(C.EMAIL,'************') | ESTADO | NUMERO   | --> A FUNÇÃO APARECE NO TÍTULO, ENTÃO VAMOS DAR UM JEITO!
+---------+--------------------------------+--------+----------+
| JORGE   | JORGE@IG.COM                   | ES     | 78458743 |
| JORGE   | JORGE@IG.COM                   | ES     | 56576876 |
| JOAO    | JOAOA@IG.COM                   | RJ     | 87866896 |
| CARLOS  | CARLOSA@IG.COM                 | RJ     | 54768899 |
| JOAO    | JOAOA@IG.COM                   | RJ     | 99667587 |
| ANA     | ANA@IG.COM                     | SP     |          |
| ANA     | ANA@IG.COM                     | SP     |          |
| JOAO    | JOAOA@IG.COM                   | RJ     | 66687899 |
| JORGE   | JORGE@IG.COM                   | ES     | 89986668 |
| CARLOS  | CARLOSA@IG.COM                 | RJ     | 88687909 |
| FLAVIO  | FLAVIO@IG.COM                  | MG     | 68976565 |
| FLAVIO  | FLAVIO@IG.COM                  | MG     | 99656675 |
| GIOVANA | ************                   | RJ     | 33567765 |
| GIOVANA | ************                   | RJ     | 88668786 |
| GIOVANA | ************                   | RJ     | 55689654 |
| KARLA   | KARLA@GMAIL.COM                | RJ     | 88687979 |
| DANIELE | DANIELE@GMAIL.COM              | ES     | 88965676 |
| EDUARDO | ************                   | PR     | 89966809 |
| ANTONIO | ANTONIO@IG.COM                 | SP     | 88679978 |
| ANTONIO | ANTONIO@UOL.COM                | PR     | 99655768 |
| ELAINE  | ELAINE@GLOBO.COM               | SP     | 89955665 |
| CARMEM  | CARMEM@IG.COM                  | RJ     | 77455786 |
| CARMEM  | CARMEM@IG.COM                  | RJ     | 89766554 |
| ADRIANA | ADRIANA@GMAIL.COM              | RJ     | 77755785 |
| ADRIANA | ADRIANA@GMAIL.COM              | RJ     | 44522578 |
+---------+--------------------------------+--------+----------+

SELECT  C.NOME, 
		IFNULL(C.EMAIL,'************') AS 'E-MAIL', 
		E.ESTADO, 
		T.NUMERO
FROM CLIENTE C
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE;

+---------+-------------------+--------+----------+
| NOME    | E-MAIL            | ESTADO | NUMERO   |
+---------+-------------------+--------+----------+
| JORGE   | JORGE@IG.COM      | ES     | 78458743 |
| JORGE   | JORGE@IG.COM      | ES     | 56576876 |
| JOAO    | JOAOA@IG.COM      | RJ     | 87866896 |
| CARLOS  | CARLOSA@IG.COM    | RJ     | 54768899 |
| JOAO    | JOAOA@IG.COM      | RJ     | 99667587 |
| ANA     | ANA@IG.COM        | SP     |          |
| ANA     | ANA@IG.COM        | SP     |          |
| JOAO    | JOAOA@IG.COM      | RJ     | 66687899 |
| JORGE   | JORGE@IG.COM      | ES     | 89986668 |
| CARLOS  | CARLOSA@IG.COM    | RJ     | 88687909 |
| FLAVIO  | FLAVIO@IG.COM     | MG     | 68976565 |
| FLAVIO  | FLAVIO@IG.COM     | MG     | 99656675 |
| GIOVANA | ************      | RJ     | 33567765 |
| GIOVANA | ************      | RJ     | 88668786 |
| GIOVANA | ************      | RJ     | 55689654 |
| KARLA   | KARLA@GMAIL.COM   | RJ     | 88687979 |
| DANIELE | DANIELE@GMAIL.COM | ES     | 88965676 |
| EDUARDO | ************      | PR     | 89966809 |
| ANTONIO | ANTONIO@IG.COM    | SP     | 88679978 |
| ANTONIO | ANTONIO@UOL.COM   | PR     | 99655768 |
| ELAINE  | ELAINE@GLOBO.COM  | SP     | 89955665 |
| CARMEM  | CARMEM@IG.COM     | RJ     | 77455786 |
| CARMEM  | CARMEM@IG.COM     | RJ     | 89766554 |
| ADRIANA | ADRIANA@GMAIL.COM | RJ     | 77755785 |
| ADRIANA | ADRIANA@GMAIL.COM | RJ     | 44522578 |
+---------+-------------------+--------+----------+


--> CRIANDO VIEWS

CREATE VIEW V_RELATORIO AS
SELECT C.NOME,
	   C.SEXO,
	   IFNULL(C.EMAIL, '************') AS 'E-MAIL',
	   T.TIPO,
	   T.NUMERO,
	   E.BAIRRO,
	   E.CIDADE,
	   E.ESTADO
FROM CLIENTE C
INNER JOIN TELEFONE T
ON C.IDCLIENTE = T.ID_CLIENTE
INNER JOIN ENDERECO E
ON C.IDCLIENTE = E.ID_CLIENTE;

/* OBSERVAÇÕES
--> AS VIEWS SERVEM PARA CRIARMOS UM "PRESET" DE UMA BUSCA.
SÃO UTILIZADAS PARA GUARDAR UMA QUERY EM UMA VARIÁVEL QUE TRARÁ
TODAS AS COLUNAS DESCRITAS NO COMANDO DE PROJEÇÃO.

--> TAMBÉM É POSSÍVEL REALIZAR CONSULTAS COM OS CAMPOS QUE PERTENCEM ÀS VIEWS.

*/

SELECT NOME, NUMERO, ESTADO
FROM V_RELATORIO;

--> SE ESQUECERMOS UMA VÍRGULA DE SEPARAÇÃO DAS COLUNAS,
--   A COLUNA À DIREIRA SERÁ NOMEADA COM A COLUNA SEGUINTE.

SELECT NOME, NUMERO ESTADO
FROM V_RELATORIO;
+---------+----------+
| NOME    | ESTADO   | --> APENAS DUAS COLUNAS E O NUMERO RECEBEU O NOME DE ESTADO.
+---------+----------+
| JORGE   | 78458743 |
| JORGE   | 56576876 |
| JOAO    | 87866896 |
| CARLOS  | 54768899 |
| JOAO    | 99667587 |
| ANA     |          |
| ANA     |          |
| JOAO    | 66687899 |
| JORGE   | 89986668 |
| CARLOS  | 88687909 |
| FLAVIO  | 68976565 |
| FLAVIO  | 99656675 |
| GIOVANA | 33567765 |
| GIOVANA | 88668786 |
| GIOVANA | 55689654 |
| KARLA   | 88687979 |
| DANIELE | 88965676 |
| EDUARDO | 89966809 |
| ANTONIO | 88679978 |
| ANTONIO | 99655768 |
| ELAINE  | 89955665 |
| CARMEM  | 77455786 |
| CARMEM  | 89766554 |
| ADRIANA | 77755785 |
| ADRIANA | 44522578 |
+---------+----------+

