-- Remover as chaves estrangeiras das tabelas que referenciam outras tabelas
ALTER TABLE IF EXISTS Diagnostico DROP CONSTRAINT IF EXISTS Diagnostico_IdCon_fkey;
ALTER TABLE IF EXISTS ExerceEsp DROP CONSTRAINT IF EXISTS ExerceEsp_IdEsp_fkey;
ALTER TABLE IF EXISTS ExerceEsp DROP CONSTRAINT IF EXISTS ExerceEsp_CRM_fkey;
ALTER TABLE IF EXISTS Agenda DROP CONSTRAINT IF EXISTS Agenda_CRM_fkey;

-- Remover as tabelas se existirem
DROP TABLE IF EXISTS Diagnostico;
DROP TABLE IF EXISTS Doenca;
DROP TABLE IF EXISTS Consulta;
DROP TABLE IF EXISTS ExerceEsp;
DROP TABLE IF EXISTS Especialidade;
DROP TABLE IF EXISTS Agenda;
DROP TABLE IF EXISTS Paciente;
DROP TABLE IF EXISTS Medico;

-- Remover os tipos enumerados se existirem
DROP TYPE IF EXISTS Pagamentos_Aceitos;
DROP TYPE IF EXISTS Nome_Doenca;
DROP TYPE IF EXISTS Nome_Especialidade;
DROP TYPE IF EXISTS S_EXO;