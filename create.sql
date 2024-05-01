CREATE TABLE Medico (
    CRM INT PRIMARY KEY,
    Nome CHAR(50) NOT NULL,
    Sobrenome CHAR(50) NOT NULL,
    Telefone VARCHAR(20) NOT NULL,
    Percentual INT NOT NULL,

    CONSTRAINT CK_Percentual CHECK ( Percentual <= 100 AND Percentual >= 0)
);

CREATE TYPE S_EXO AS ENUM ('M', 'F', 'Outro');
CREATE TABLE Paciente (
    IdPac INT PRIMARY KEY,
    CPF INT NOT NULL,
    Nome VARCHAR(50) NOT NULL,
    Telefone VARCHAR(20) NOT NULL,
    Endereco VARCHAR(50) NOT NULL,
    Idade INT NOT NULL,
    Sexo S_EXO NOT NULL
);

CREATE TABLE Agenda (
    IdAgenda INT PRIMARY KEY,
    Dia DATE,
    HoraInicio TIME,
    HoraFim TIME,
    CRM INT,

    FOREIGN KEY (CRM) REFERENCES Medico(CRM),

    CONSTRAINT CK_Horarios CHECK ( HoraInicio < HoraFim )
);

CREATE TYPE Nome_Especialidade AS ENUM ('Dermatologia', 'Oncologia', 'Oftalmologista');
CREATE TABLE Especialidade (
    IdEsp INT PRIMARY KEY,
    Nome Nome_Especialidade NOT NULL,
    Indice VARCHAR(50)
);


CREATE TABLE ExerceEsp (
    CRM INT,
    IdEsp INT,
    PRIMARY KEY (CRM, IdEsp),
    FOREIGN KEY (CRM) REFERENCES Medico(CRM),
    FOREIGN KEY (IdEsp) REFERENCES Especialidade(IdEsp)
);



CREATE TYPE Pagamentos_Aceitos AS ENUM ('Pix', 'Débito', 'Crédito', 'Boleto');
CREATE TABLE Consulta (
    IdCon INT PRIMARY KEY,
    CRM INT NOT NULL,
    IdEsp INT NOT NULL,
    IdPac INT NOT NULL,
    Dia DATE NOT NULL,
    HoraInicioCon TIME NOT NULL,
    HoraFimCon TIME NOT NULL,
    Pagou BOOLEAN DEFAULT FALSE,
    ValorPago FLOAT,
    FormaPagamento Pagamentos_Aceitos,

    FOREIGN KEY (CRM) REFERENCES Medico(CRM),
    FOREIGN KEY (IdEsp) REFERENCES Especialidade(IdEsp),
    FOREIGN KEY (IdPac) REFERENCES Paciente(IdPac),

    CONSTRAINT CK_Horarios CHECK ( HoraFimCon > HoraInicioCon )

);

CREATE TABLE Diagnostico (
    IdDiagnostico INT PRIMARY KEY,
    TratamentoRecomendado VARCHAR(50) NOT NULL,
    RemediosReceitados VARCHAR(50),
    Observacoes VARCHAR(50),
    IdCon INT NOT NULL,

    FOREIGN KEY (IdCon) REFERENCES Consulta(IdCon)
);

CREATE TYPE Nome_Doenca AS ENUM ('Dengue', 'Malária', 'Linfoma');
CREATE TABLE Doenca (
    IdDoenca INT PRIMARY KEY,
    Nome VARCHAR(50) UNIQUE NOT NULL 
);

CREATE TABLE Diagnostica (
    IdDiagnostico INT,
    IdDoenca INT,

    PRIMARY KEY (IdDiagnostico, IdDoenca),
    FOREIGN KEY (IdDiagnostico) REFERENCES Diagnostico(IdDiagnostico),
    FOREIGN KEY (IdDoenca) REFERENCES Doenca(IdDoenca)
);
