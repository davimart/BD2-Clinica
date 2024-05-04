/*3. Resolver as seguintes consultas e atualizações. Você deve apresentar o
estado do BD antes da transação e depois da execução. No caso das consultas,
vocês devem apresentar o script da consulta e o resultado das consultas:
a) Listar as consultas (IdMedico, IdPaciente, IdEspecial, Data, HoraInicCon)
marcadas pelo paciente “Diego Pituca” com o “Dr. House”.
*/

SELECT C.CRM, C.IdPac, C.IdEsp, C.Dia, C.HoraInicioCon
FROM Consulta AS C
JOIN Paciente AS P ON C.IdPac = P.IdPac
JOIN Medico AS M ON  C.CRM = M.CRM
WHERE P.Nome = 'Diego Pituca' AND M.Nome = 'Dr. House';

--b) Listar os médicos (CRM, NomeM) que atendem somente na especialidade
--“Dermatologia”.

SELECT DISTINCT Medico.CRM, Medico.Nome
FROM Medico AS M
JOIN ExerceEsp AS EE ON M.CRM = EE.CRM
JOIN Especialidade AS E ON EE.IdEsp = E.IdEsp
WHERE Especialidade.Nome = 'Dermatologia';

--c) Listar os médicos (CRM, NomeM) que atendem todas as especialidades.

SELECT CRM, Nome
FROM Medico NATURAL JOIN ExerceEsp
WHERE Espec = 

---MAIS CHATINHO E TEM QUE FAZER

--d) Listar os pacientes (CPF, NomeP) consultados pelo “Dr. House” como
“Cardiologista”.

SELECT P.CPF, P.Nome
FROM Paciente AS P JOIN Consulta AS C ON P.IdPac = C.IdPac
	JOIN Medico AS M ON C.CRM = M.CRM
	JOIN ExerceEsp AS EE ON M.CRM = EE.CRM
	JOIN Especialidade AS E ON EE.IdEsp = E.IdEsp
WHERE M.Nome = 'House' AND E.Nome = 'Cardiologia' -- ADICIONAR CARDIOLOGIA A LISTA DE ESPECIALIDADES


--e) Listar o nome dos médicos que atendem consultas todos os dias da semana.
--Como o atributo “Dia” da tabela “Agenda” representa uma data e não um dia da semana, 
--a consulta será feita apenas para a semana atual. Caso seja preciso saber 

SELECT M.Nome, M.Sobrenome
FROM Medico as M
JOIN Consulta as C ON M.CRM = C.CRM
WHERE C.Dia BETWEEN CURRENT_DATE AND (CURRENT_DATE + INTERVAL '7' DAY)
GROUP BY M.CRM, M.Nome, M.Sobrenome
HAVING COUNT(DISTINCT C.Dia) = 7;

--f) Listar as consultas (IdMedico, IdPaciente, IdEspecial, Data, HoraInicCon)
--feitas no mês de janeiro de 2024.

SELECT CONCAT(M.Nome, ' ', M.Sobrenome) AS NomeMedico, P.Nome AS NomePaciente, E.Nome AS Especialidade, C.Dia AS Data, C.HoraInicioCon AS Horário
FROM Consulta as C
JOIN Medico as M ON C.CRM = M.CRM
JOIN Paciente as P ON C.IdPac = P.IdPac
JOIN Especialidade as E ON C.IdEsp = E.IdEsp
WHERE EXTRACT(MONTH FROM C.Dia) = 1 AND EXTRACT(YEAR FROM C.Dia) = 2024;

--g) Qual é a quantidade total de consultas feitas pelo “Dr. House” por
--especialidade?

SELECT E.Nome AS Especialidade, COUNT(C.IdCon) AS QuantidadeConsultas
FROM Medico as M
JOIN Consulta as C ON M.CRM = C.CRM
JOIN Especialidade as E ON C.IdEsp = E.IdEsp
WHERE CONCAT(M.Nome, ' ', M.Sobrenome) = 'House'
GROUP BY E.Nome;

--h) Quais são os médicos (CRM, NomeM) com o menor número de consultas
--atendidas?

SELECT M.CRM, CONCAT(M.Nome, ' ', M.Sobrenome) AS NomeMedico
FROM Medico as M
LEFT JOIN Consulta as C ON M.CRM = C.CRM
GROUP BY M.CRM, M.Nome, M.Sobrenome
HAVING COUNT(C.IdCon) = (
    SELECT COUNT(IdCon)
    FROM Consulta
    GROUP BY CRM
    ORDER BY COUNT(IdCon) ASC
    LIMIT 1
);

--i) Remover todos as consultas não pagas.

DELETE FROM Diagnostico
WHERE IdCon IN (
    SELECT IdCon
    FROM Consulta
    WHERE Pagou = FALSE
);
DELETE FROM Consulta
WHERE Pagou = FALSE;

/*
j) Transferir a consulta do paciente “Diego Pituca” no dia “10/05/2024” às 10
a:m,na Especialidade “dermatologia”, com o “Dr. House”, para o dia
“24/05/2024”, na mesma hora, como o “Dr. Kildare”, na mesma especialidade.
*/
UPDATE Consulta
SET CRM = (SELECT CRM FROM Medico WHERE CONCAT(Nome, ' ', Sobrenome) = 'Dr. Kildare'),
    Dia = '2024-05-24'
WHERE IdCon = [
    SELECT IdCon
    FROM Consulta
    JOIN Medico ON Consulta.CRM = Medico.CRM
    JOIN Paciente ON Consulta.IdPac = Paciente.IdPac
    JOIN Especialidade ON Consulta.IdEsp = Especialidade.IdEsp
    WHERE CONCAT(Medico.Nome, ' ', Medico.Sobrenome) = 'Dr. House'
         AND Paciente.Nome = 'Diego Pituca'
         AND Consulta.Dia = '2024-05-10'
         AND Consulta.HoraInicioCon = '10:00:00'
         AND Especialidade.Nome = 'Dermatologia';
];
