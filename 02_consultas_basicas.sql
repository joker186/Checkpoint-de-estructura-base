-- ============================================================================
--  Nivel 2: Consultas Básicas
--  SELECT, WHERE, ORDER BY, DISTINCT, TOP, LIKE, BETWEEN
--  Base de datos: DB_Analisis_Suscripciones
-- ============================================================================

USE DB_Analisis_Suscripciones;
GO

-- ---------------------------------------------------------------------------
--  1. SELECT básico — elegir columnas específicas
-- ---------------------------------------------------------------------------

-- 1.1) Nombres de todos los planes
SELECT nombre_plan FROM planes;
GO

-- 1.2) Nombres y precios de los planes
SELECT nombre_plan, precio_mensual FROM planes;
GO

-- ---------------------------------------------------------------------------
--  2. SELECT con WHERE — filtrar con comparaciones y operadores lógicos
-- ---------------------------------------------------------------------------

-- 2.1) Planes con precio mayor a 50
SELECT nombre_plan, precio_mensual
FROM planes
WHERE precio_mensual > 50;
GO

-- 2.2) Suscriptores de Argentina o España
SELECT nombre, pais
FROM suscriptores
WHERE pais = 'Argentina' OR pais = 'España';
GO

-- 2.3) Suscripciones activas cuyo plan cuesta más de 50
--     (WHERE con AND + comparación >)
SELECT s.id_suscripcion, s.estado, p.nombre_plan, p.precio_mensual
FROM suscripciones AS s
INNER JOIN planes AS p ON s.id_plan = p.id_plan
WHERE s.estado = 'activa'
  AND p.precio_mensual > 50;
GO

-- ---------------------------------------------------------------------------
--  3. ORDER BY — ordenar resultados
-- ---------------------------------------------------------------------------

-- 3.1) Planes ordenados por precio de mayor a menor
SELECT nombre_plan, precio_mensual
FROM planes
ORDER BY precio_mensual DESC;
GO

-- 3.2) Suscriptores ordenados por fecha de registro (más recientes primero)
SELECT nombre, pais, fecha_registro
FROM suscriptores
ORDER BY fecha_registro DESC;
GO

-- ---------------------------------------------------------------------------
--  4. DISTINCT — valores únicos
-- ---------------------------------------------------------------------------

-- 4.1) Países únicos de los suscriptores
SELECT DISTINCT pais FROM suscriptores;
GO

-- 4.2) Métodos de pago únicos usados en suscripciones
SELECT DISTINCT metodo_pago FROM suscripciones;
GO

-- ---------------------------------------------------------------------------
--  5. TOP — limitar el número de filas
-- ---------------------------------------------------------------------------

-- 5.1) Los 2 planes más caros
SELECT TOP 2 nombre_plan, precio_mensual
FROM planes
ORDER BY precio_mensual DESC;
GO

-- ---------------------------------------------------------------------------
--  6. LIKE — filtrar con patrones
-- ---------------------------------------------------------------------------

-- 6.1) Planes cuyo nombre contiene "Anual"
SELECT nombre_plan, precio_mensual
FROM planes
WHERE nombre_plan LIKE '%Anual%';
GO

-- 6.2) Suscriptores cuyo email termina en ".com"
SELECT nombre, email
FROM suscriptores
WHERE email LIKE '%.com';
GO

-- ---------------------------------------------------------------------------
--  7. BETWEEN — rango de valores
-- ---------------------------------------------------------------------------

-- 7.1) Planes con precio entre 10 y 100
SELECT nombre_plan, precio_mensual
FROM planes
WHERE precio_mensual BETWEEN 10 AND 100;
GO

-- ---------------------------------------------------------------------------
--  8. IS NULL / IS NOT NULL — valores nulos
-- ---------------------------------------------------------------------------

-- 8.1) Suscripciones sin fecha de fin (fecha_fin IS NULL)
SELECT id_suscripcion, id_suscriptor, id_plan, fecha_inicio, estado
FROM suscripciones
WHERE fecha_fin IS NULL;
GO

-- 8.2) Suscripciones con fecha de fin definida (fecha_fin IS NOT NULL)
SELECT id_suscripcion, fecha_inicio, fecha_fin, estado
FROM suscripciones
WHERE fecha_fin IS NOT NULL;
GO
