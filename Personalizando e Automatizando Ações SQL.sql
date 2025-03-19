use company_constraints;
show tables;
             
CREATE USER 'Franklin'@'%' IDENTIFIED BY 'SenhaForte';
GRANT SELECT ON EmpregadoPorDepartamentoELocalizacao TO 'Franklin'@'localhost';
FLUSH PRIVILEGES;

grant all privileges on testuser.nome_view to 'geral'@localhost;
CREATE VIEW EmpregadoPorDepartamentoELocalizacao AS
SELECT 
    d.Dname AS Departamento,
    dl.Dlocation AS Localizacao,
    COUNT(e.Ssn) AS NumeroDeEmpregados
FROM 
    departament d
JOIN 
    dept_locations dl ON d.Dnumber = dl.Dnumber
LEFT JOIN 
    employee e ON e.Dno = d.Dnumber
GROUP BY 
    d.Dname, dl.Dlocation;

GRANT SELECT ON EmpregadoPorDepartamentoELocalizacao TO NomeDoUsuario;

select * from EmpregadoPorDepartamentoELocalizacao;

CREATE VIEW ListaDepartamentosGerentes AS
SELECT 
    d.Dname AS NomeDepartamento,
    e.Fname AS NomeGerente,
    e.Lname AS SobrenomeGerente,
    d.Mgr_start_date AS DataInicioGerencia
FROM 
    departament d
JOIN 
    employee e ON d.Mgr_ssn = e.Ssn;
select * from ListaDepartamentosGerentes;


CREATE VIEW ProjetosComMaisEmpregados AS
SELECT 
    p.Pname AS NomeProjeto,
    COUNT(w.Essn) AS NumeroDeEmpregados
FROM 
    project p
JOIN 
    works_on w ON p.Pnumber = w.Pno
GROUP BY 
    p.Pname
ORDER BY 
    NumeroDeEmpregados DESC;
    
    select * from ProjetosComMaisEmpregados;
    
    CREATE VIEW ProjetosDepartamentosGerentes AS
SELECT 
    p.Pname AS NomeProjeto,
    d.Dname AS NomeDepartamento,
    e.Fname AS NomeGerente,
    e.Lname AS SobrenomeGerente
FROM 
    project p
JOIN 
    departament d ON p.Dnum = d.Dnumber
JOIN 
    employee e ON d.Mgr_ssn = e.Ssn;
    
    select * from ProjetosDepartamentosGerentes;
    
    CREATE VIEW EmpregadosComDependentesGerencia AS
SELECT 
    e.Fname AS NomeEmpregado,
    e.Lname AS SobrenomeEmpregado,
    CASE WHEN e.Ssn IN (SELECT d.Mgr_ssn FROM departament d) THEN 'Sim' ELSE 'Não' END AS EhGerente,
    COUNT(d.Dependent_name) AS NumeroDeDependentes
FROM 
    employee e
LEFT JOIN 
    dependent d ON e.Ssn = d.Essn
GROUP BY 
    e.Ssn, e.Fname, e.Lname;
    
    select * from EmpregadosComDependentesGerencia;
    
    -- Criando usuário gerente
CREATE USER gerente IDENTIFIED BY '123456789';
GRANT SELECT ON employee TO gerente;
GRANT SELECT ON departamento TO gerente;

-- Criando usuário employee

CREATE USER employee IDENTIFIED BY '987654321';
GRANT SELECT ON employee TO employee;







