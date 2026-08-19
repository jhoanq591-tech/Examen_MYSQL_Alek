CREATE DATABASE IF NOT EXISTS proyectocentrodesalud;
USE proyectocentrodesalud;

CREATE TABLE IF NOT EXISTS medicos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    documento INT NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    especialidad VARCHAR(100) NOT NULL,
    tipo VARCHAR(9) NOT NULL,
    dia_de_la_semana VARCHAR(100) NOT NULL,
    hora_inicio_y_fin_de_consulta VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS empleados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    documento INT NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    cargo VARCHAR(100) NOT NULL,
    turno VARCHAR(100) NOT NULL
);    

CREATE TABLE IF NOT EXISTS pacientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    documento INT NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    fecha_de_nacimiento DATE NOT NULL,
    telefono VARCHAR(20),
    id_medico_asignado INT,
    FOREIGN KEY (id_medico_asignado) REFERENCES medicos(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS sustituciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_medico_sustituto INT NOT NULL,
    id_medico_sustituido INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    FOREIGN KEY (id_medico_sustituto) REFERENCES medicos(id),
    FOREIGN KEY (id_medico_sustituido) REFERENCES medicos(id)
); 

CREATE TABLE IF NOT EXISTS vacaciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_medico INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    estado VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_medico) REFERENCES medicos(id) ON DELETE CASCADE
);