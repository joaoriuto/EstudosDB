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