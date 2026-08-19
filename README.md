# 🏥 Centro de Salud — Sistema de Gestión de Base de Datos Relacional

Un sistema de base de datos relacional robusto y escalable diseñado en **MySQL** para optimizar la administración de un centro médico integral. Permite gestionar personal médico, empleados administrativos, historial de pacientes, asignaciones directas, cronograma de sustituciones y solicitudes de vacaciones.

---

## 📑 Tabla de Contenidos

1. [Arquitectura del Sistema](#-arquitectura-del-sistema)
2. [Requisitos Previos](#-requisitos-previos)
3. [Guía de Instalación y Ejecución](#-guía-de-instalación-y-ejecución)
   - [Paso 1: Estructura de la Base de Datos](#paso-1-estructura-de-la-base-de-datos)
   - [Paso 2: Población de Datos](#paso-2-población-de-datos)
4. [Consultas SQL de Analítica (10 Casos)](#-consultas-sql-de-analítica)
5. [Modelado de Datos (E-R)](#-modelado-de-datos)

---

## 🏗️ Arquitectura del Sistema

El modelo relacional se compone de 5 entidades interconectadas estratégicamente:

```
                  ┌──────────────┐
                  │   MEDICOS    │◄──────────────┐
                  └──────┬───────┘               │
                         │                       │
      ┌──────────────────┼──────────────────┐    │
      ▼                  ▼                  ▼    │
┌───────────┐    ┌───────────────┐    ┌──────────┴────┐
│ PACIENTES │    │ SUSTITUCIONES │    │  VACACIONES   │
└───────────┘    └───────────────┘    └───────────────┘
```

- **`medicos`**: Tabla principal de personal médico (Especialidad, tipo, agenda).
- **`empleados`**: Gestión del personal administrativo, enfermería y soporte.
- **`pacientes`**: Registro de usuarios asignados a un médico tratante.
- **`sustituciones`**: Control de cobertura entre médicos titulares y sustitutos.
- **`vacaciones`**: Historial y estado de las solicitudes de vacaciones por médico.

---

## 🛠️ Requisitos Previos

| Requisito | Versión Mínima Recomendada |
| :--- | :--- |
| **MySQL Server** | `8.0` o superior |
| **MySQL Workbench** / **DBeaver** | Última versión |
| **Visual Studio Code** | Extensión *Database Client* o *MySQL* |

---

## 🚀 Guía de Instalación y Ejecución

### Paso 1: Estructura de la Base de Datos

Ejecuta este script en tu cliente SQL para crear la base de datos `proyectocentrodesalud` y sus tablas con restricciones de clave foránea (*Foreign Keys*):

```sql
CREATE DATABASE IF NOT EXISTS proyectocentrodesalud;
USE proyectocentrodesalud;

-- 1. Tabla de Médicos
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

-- 2. Tabla de Empleados
CREATE TABLE IF NOT EXISTS empleados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    documento INT NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    cargo VARCHAR(100) NOT NULL,
    turno VARCHAR(100) NOT NULL
);    

-- 3. Tabla de Pacientes
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

-- 4. Tabla de Sustituciones
CREATE TABLE IF NOT EXISTS sustituciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_medico_sustituto INT NOT NULL,
    id_medico_sustituido INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    FOREIGN KEY (id_medico_sustituto) REFERENCES medicos(id),
    FOREIGN KEY (id_medico_sustituido) REFERENCES medicos(id)
); 

-- 5. Tabla de Vacaciones
CREATE TABLE IF NOT EXISTS vacaciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_medico INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    estado VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_medico) REFERENCES medicos(id) ON DELETE CASCADE
);
```

---

### Paso 2: Población de Datos

Carga datos iniciales para probar las consultas del sistema:

```sql
USE proyectocentrodesalud;

-- Registrar Médicos
INSERT INTO medicos (documento, nombre, apellido, especialidad, tipo, dia_de_la_semana, hora_inicio_y_fin_de_consulta) VALUES
(10111111, 'Carlos', 'Mendoza', 'Cardiología', 'Titular', 'Lunes, Miércoles', '08:00 - 14:00'),
(10222222, 'Elena', 'Ríos', 'Pediatría', 'Sustituto', 'Martes, Jueves', '10:00 - 16:00'),
(10333333, 'Roberto', 'Gómez', 'General', 'Titular', 'Lunes a Viernes', '07:00 - 13:00');

-- Registrar Empleados
INSERT INTO empleados (documento, nombre, apellido, cargo, turno) VALUES
(1098765432, 'Carlos', 'Gómez', 'Recepcionista', 'Mañana'),
(1098765433, 'María', 'Rodríguez', 'Enfermera Jefe', 'Tarde'),
(1098765434, 'Laura', 'Martínez', 'Auxiliar Administrativo', 'Mañana'),
(1098765435, 'Andrés', 'López', 'Técnico de Sistemas', 'Noche');

-- Registrar Pacientes
INSERT INTO pacientes (documento, nombre, apellido, fecha_de_nacimiento, telefono, id_medico_asignado) VALUES
(1012345601, 'Ana', 'Pérez', '1995-04-12', '3001234567', 1),
(1012345602, 'Luis', 'Hernández', '1988-11-23', '3159876543', 2),
(1012345603, 'Sofia', 'Torres', '2001-07-05', '3204567890', 1),
(1012345604, 'Jorge', 'Ramírez', '1975-02-18', '3116543210', 3);

-- Registrar Sustituciones
INSERT INTO sustituciones (id_medico_sustituto, id_medico_sustituido, fecha_inicio, fecha_fin) VALUES
(2, 1, '2026-09-01', '2026-09-15'),
(3, 2, '2026-10-10', '2026-10-20');

-- Registrar Vacaciones
INSERT INTO vacaciones (id_medico, fecha_inicio, fecha_fin, estado) VALUES
(1, '2026-09-01', '2026-09-15', 'Aprobado'),
(2, '2026-10-10', '2026-10-20', 'Aprobado'),
(3, '2026-12-01', '2026-12-15', 'Pendiente');
```

---

## 🔍 Consultas SQL de Analítica

> ⚠️ **RESTRICCIÓN CUMPLIDA:** Todas las consultas han sido construidas haciendo uso **exclusivo** de las cláusulas base: `FROM`, `WHERE`, `INTO`, `HAVING`, `ORDER BY` y `GROUP BY`.

<details>
<summary><b>📌 01. Pacientes asignados por médico (Con más de 1 paciente)</b></summary>

```sql
SELECT id_medico_asignado, COUNT(*) AS total_pacientes
FROM pacientes
WHERE id_medico_asignado IS NOT NULL
GROUP BY id_medico_asignado
HAVING COUNT(*) > 1
ORDER BY total_pacientes DESC;
```
- **Lógica:** Filtra pacientes con médico asignado (`WHERE`), agrupa por el ID del médico (`GROUP BY`) y evalúa que la cantidad acumulada sea superior a 1 (`HAVING`).
</details>

<details>
<summary><b>📌 02. Personal del turno de la mañana ordenado por apellido</b></summary>

```sql
SELECT nombre, apellido, cargo
FROM empleados
WHERE turno = 'Mañana'
ORDER BY apellido ASC;
```
- **Lógica:** Extrae de la tabla `empleados` solo aquellos cuyo turno coincida con `'Mañana'` (`WHERE`) y ordena el resultado alfabéticamente (`ORDER BY`).
</details>

<details>
<summary><b>📌 03. Total de vacaciones aprobadas por médico</b></summary>

```sql
SELECT id_medico, COUNT(*) AS vacaciones_aprobadas
FROM vacaciones
WHERE estado = 'Aprobado'
GROUP BY id_medico
ORDER BY vacaciones_aprobadas DESC;
```
- **Lógica:** Filtra los registros en estado `'Aprobado'` (`WHERE`) y los consolida según el identificador de cada médico (`GROUP BY`).
</details>

<details>
<summary><b>📌 04. Listado de pacientes nacidos desde 1990</b></summary>

```sql
SELECT nombre, apellido, fecha_de_nacimiento
FROM pacientes
WHERE fecha_de_nacimiento >= '1990-01-01'
ORDER BY fecha_de_nacimiento ASC;
```
- **Lógica:** Selecciona pacientes con fecha de nacimiento posterior o igual a enero de 1990 (`WHERE`) y los ordena del más antiguo al más reciente (`ORDER BY`).
</details>

<details>
<summary><b>📌 05. Clasificación de médicos por su modalidad (Titular / Sustituto)</b></summary>

```sql
SELECT tipo, COUNT(*) AS cantidad_medicos
FROM medicos
WHERE tipo IS NOT NULL
GROUP BY tipo
ORDER BY cantidad_medicos DESC;
```
- **Lógica:** Agrupa los registros válidos de médicos (`WHERE`) según la categoría registrada en su campo `tipo` (`GROUP BY`).
</details>

<details>
<summary><b>📌 06. Conteo de servicios realizados por médico sustituto</b></summary>

```sql
SELECT id_medico_sustituto, COUNT(*) AS total_sustituciones
FROM sustituciones
WHERE id_medico_sustituto IS NOT NULL
GROUP BY id_medico_sustituto
HAVING COUNT(*) >= 1
ORDER BY total_sustituciones DESC;
```
- **Lógica:** Agrupa la tabla de reemplazos por el ID del médico encargado (`GROUP BY`), garantizando mostrar registros activos (`HAVING`).
</details>

<details>
<summary><b>📌 07. Respaldo de médicos titulares a archivo externo (Uso de INTO)</b></summary>

```sql
SELECT id, documento, nombre, apellido, especialidad
INTO OUTFILE '/tmp/medicos_titulares.csv'
FROM medicos
WHERE tipo = 'Titular'
ORDER BY apellido ASC;
```
- **Lógica:** Exporta la información de médicos de tipo `'Titular'` directamente a un archivo externo utilizando la sintaxis `INTO OUTFILE`.
</details>

<details>
<summary><b>📌 08. Distribución de empleados según su cargo</b></summary>

```sql
SELECT cargo, COUNT(*) AS total_empleados
FROM empleados
WHERE cargo IS NOT NULL
GROUP BY cargo
HAVING COUNT(*) >= 1
ORDER BY cargo ASC;
```
- **Lógica:** Agrupa y cuenta cuántos trabajadores pertenecen a cada cargo dentro del centro de salud (`GROUP BY` + `HAVING`).
</details>

<details>
<summary><b>📌 09. Cronograma de sustituciones del segundo semestre de 2026</b></summary>

```sql
SELECT id, id_medico_sustituto, id_medico_sustituido, fecha_inicio
FROM sustituciones
WHERE fecha_inicio >= '2026-07-01'
ORDER BY fecha_inicio ASC;
```
- **Lógica:** Filtra únicamente las sustituciones cuyo período comience a partir del 1 de julio de 2026 (`WHERE`) de forma cronológica (`ORDER BY`).
</details>

<details>
<summary><b>📌 10. Control de solicitudes de vacaciones pendientes por médico</b></summary>

```sql
SELECT id_medico, estado, COUNT(*) AS total_solicitudes
FROM vacaciones
WHERE estado = 'Pendiente'
GROUP BY id_medico, estado
HAVING COUNT(*) > 0
ORDER BY id_medico ASC;
```
- **Lógica:** Consulta las peticiones no procesadas (`WHERE`), agrupándolas por médico para determinar requerimientos en espera (`GROUP BY` + `HAVING`).
</details>

---

<div align="center">
  <sub>Proyecto Centro de Salud • Creado con ❤️ para gestión hospitalaria eficiente.</sub>
</div>