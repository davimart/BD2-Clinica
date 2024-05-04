-- Populando a tabela Medico
INSERT INTO Medico (CRM, Nome, Sobrenome, Telefone, Percentual) VALUES
(123456, 'Gregory', 'House', '(11) 91234-5678', 80),
(234567, 'Maria', 'Santos', '(11) 98765-4321', 75),
(345678, 'Carlos', 'Oliveira', '(11) 99999-9999', 90),
(456789, 'Ana', 'Ferreira', '(11) 87654-3210', 85),
(567890, 'Pedro', 'Almeida', '(11) 11111-1111', 70);

-- Populando a tabela Especialidade
INSERT INTO Especialidade (IdEsp, Nome, Indice) VALUES
(1, 'Dermatologia', 'IND_DERM'),
(2, 'Oncologia', 'IND_ONCO'),
(3, 'Oftalmologista', 'IND_OFTAL');

-- Populando a tabela ExerceEsp
INSERT INTO ExerceEsp (CRM, IdEsp) VALUES
(123456, 1),
(234567, 2),
(345678, 3),
(456789, 1),
(567890, 2);

-- Populando a tabela Paciente
INSERT INTO Paciente (IdPac, CPF, Nome, Telefone, Endereco, Idade, Sexo) VALUES
(1, 12345678901, 'Diego Pituca', '(11) 55555-5555', 'Rua A, 123', 35, 'M'),
(2, 23456789012, 'Maria', '(11) 66666-6666', 'Rua B, 456', 45, 'F'),
(3, 34567890123, 'Paulo', '(11) 77777-7777', 'Rua C, 789', 25, 'M'),
(4, 45678901234, 'Luísa', '(11) 88888-8888', 'Rua D, 012', 55, 'F'),
(5, 56789012345, 'Ana', '(11) 99999-9999', 'Rua E, 345', 30, 'F');

-- Populando a tabela Doenca
INSERT INTO Doenca (IdDoenca, Nome) VALUES
(1, 'Dengue'),
(2, 'Malária'),
(3, 'Linfoma');

-- Populando a tabela Consulta
INSERT INTO Consulta (IdCon, CRM, IdEsp, IdPac, Dia, HoraInicioCon, HoraFimCon, Pagou, ValorPago, FormaPagamento) VALUES
(1, 123456, 1, 1, '2024-05-01', '09:00:00', '09:30:00', TRUE, 150.00, 'Crédito'),
(2, 234567, 2, 2, '2024-05-02', '10:00:00', '10:30:00', TRUE, 200.00, 'Débito'),
(3, 345678, 3, 3, '2024-05-03', '11:00:00', '11:30:00', TRUE, 180.00, 'Boleto'),
(4, 456789, 1, 4, '2024-05-04', '12:00:00', '12:30:00', TRUE, 160.00, 'Pix'),
(5, 567890, 2, 5, '2024-05-05', '13:00:00', '13:30:00', TRUE, 170.00, 'Débito');

-- Populando a tabela Diagnostico
INSERT INTO Diagnostico (IdDiagnostico, TratamentoRecomendado, RemediosReceitados, Observacoes, IdCon) VALUES
(1, 'Repouso e hidratação', 'Paracetamol', 'Sem observações', 1),
(2, 'Quimioterapia', 'Prednisona', 'Paciente em estágio avançado', 2),
(3, 'Cirurgia', NULL, 'Agendar consulta com cirurgião', 3),
(4, 'Medicação oral', 'Ibuprofeno', 'Paciente alérgico a amoxicilina', 4),
(5, 'Radioterapia', 'Dexametasona', 'Sem observações', 5);

-- Populando a tabela Diagnostica
INSERT INTO Diagnostica (IdDiagnostico, IdDoenca) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 1),
(5, 2);
