USE proyectocentrodesalud;

INSERT INTO medicos (documento, nombre, apellido, especialidad, tipo, dia_de_la_semana, hora_inicio_y_fin_de_consulta) VALUES 
(1111111111, 'Miguel', 'Henao', 'Urologo', 'Lunes-jueves', '8:00-12:00'),
(1111111112, 'Juan', 'Mendoza', 'Oftanmologo', 'Lunes-jueves', '8:00-12:00'),
(1111111113, 'Yonny', 'Bravo', 'Pedriatra', 'Lunes-jueves', '8:00-12:00'),
(1111111114, 'Alexander', 'Quintanilla', 'Pediatra', 'Lunes-sabado', '8:00-12:00'),
(1111111115, 'Nicol', 'Sherman', 'Psicologa', 'Lunes-jueves', '8:00-12:00'),
(1111111116, 'Alberth', 'Totinni', 'Nutricionista', 'Lunes-sabado', '8:00-12:00'),
(1111111117, 'Junior', 'Salsero', 'Medico General', 'Lunes-jueves', '8:00-12:00'),
(1111111118, 'Samuel', 'Diaz', 'Pediatra', 'Lunes-sabado', '8:00-12:00'),
(1111111119, 'Carlos', 'Panchoy', 'Odontologo', 'Lunes-sabado', '8:00-12:00'),
(1111111120, 'Chanty', 'Melao', 'Urologo', 'Lunes-jueves', '8:00-12:00');

INSERT INTO empleados (documento, nombre, apellido, cargo, turno) VALUES
(1098765432, 'Carlos', 'Gómez', 'Recepcionista', 'Mañana'),
(1098765433, 'María', 'Rodríguez', 'Enfermera Jefe', 'Tarde'),
(1098765434, 'Laura', 'Martínez', 'Auxiliar Administrativo', 'Mañana'),
(1098765435, 'Andrés', 'López', 'Técnico de Sistemas', 'Noche');

INSERT INTO pacientes (documento, nombre, apellido, fecha_de_nacimiento, telefono, id_medico_asignado) VALUES
(1012345601, 'Ana', 'Pérez', '1995-04-12', '3001234567', 1),
(1012345602, 'Luis', 'Hernández', '1988-11-23', '3159876543', 2),
(1012345603, 'Sofia', 'Torres', '2001-07-05', '3204567890', 1),
(1012345604, 'Jorge', 'Ramírez', '1975-02-18', '3116543210', 3);

INSERT INTO sustituciones (id_medico_sustituto, id_medico_sustituido, fecha_inicio, fecha_fin) VALUES
(2, 1, '2026-09-01', '2026-09-15'),
(3, 2, '2026-10-10', '2026-10-20');

INSERT INTO vacaciones (id_medico, fecha_inicio, fecha_fin, estado) VALUES
(1, '2026-09-01', '2026-09-15', 'Aprobado'),
(2, '2026-10-10', '2026-10-20', 'Aprobado'),
(3, '2026-12-01', '2026-12-15', 'Pendiente');