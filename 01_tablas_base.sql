-- ============================================================================
--  Script: 01_tablas_base.sql
--  Proyecto: Plataforma de Análisis de Suscripciones
--  Objetivo: Creación de la base de datos, tablas y datos semilla.
--  Motor: SQL Server 2025
-- ============================================================================

-- ---------------------------------------------------------------------------
--  1. Creación de la base de datos
-- ---------------------------------------------------------------------------

-- Eliminar la base de datos si ya existe (modo idempotente)
IF EXISTS (
    SELECT 1 FROM sys.databases WHERE name = 'DB_Analisis_Suscripciones'
)
BEGIN
    ALTER DATABASE DB_Analisis_Suscripciones SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DB_Analisis_Suscripciones;
END
GO

CREATE DATABASE DB_Analisis_Suscripciones;
GO

USE DB_Analisis_Suscripciones;
GO

-- ---------------------------------------------------------------------------
--  2. Definición de tablas
-- ---------------------------------------------------------------------------

-- Tabla: planes
-- Catálogo de planes de suscripción con su precio y duración.
CREATE TABLE planes (
    id_plan         INT           NOT NULL,
    nombre_plan     NVARCHAR(100) NOT NULL,
    precio_mensual  DECIMAL(10, 2) NOT NULL,
    descripcion     NVARCHAR(255) NULL,
    duracion_dias   INT           NOT NULL DEFAULT 30,

    CONSTRAINT PK_planes PRIMARY KEY (id_plan)
);
GO

-- Tabla: suscriptores
-- Información de contacto y registro de cada suscriptor.
CREATE TABLE suscriptores (
    id_suscriptor   INT           NOT NULL,
    nombre          NVARCHAR(100) NOT NULL,
    email           NVARCHAR(255) NOT NULL,
    telefono        VARCHAR(20)   NULL,
    pais            NVARCHAR(50)  NOT NULL,
    fecha_registro  DATE          NOT NULL,

    CONSTRAINT PK_suscriptores PRIMARY KEY (id_suscriptor),
    CONSTRAINT UQ_suscriptores_email UNIQUE (email)
);
GO

-- Tabla: suscripciones
-- Relación entre suscriptores y planes; tracking de estado y pago.
CREATE TABLE suscripciones (
    id_suscripcion  INT           NOT NULL,
    id_suscriptor   INT           NOT NULL,
    id_plan         INT           NOT NULL,
    fecha_inicio    DATE          NOT NULL,
    fecha_fin       DATE          NULL,
    estado          NVARCHAR(20)  NOT NULL,
    metodo_pago     NVARCHAR(50)  NOT NULL,

    CONSTRAINT PK_suscripciones PRIMARY KEY (id_suscripcion),
    CONSTRAINT FK_suscripciones_suscriptores
        FOREIGN KEY (id_suscriptor) REFERENCES suscriptores(id_suscriptor),
    CONSTRAINT FK_suscripciones_planes
        FOREIGN KEY (id_plan) REFERENCES planes(id_plan)
);
GO

-- ---------------------------------------------------------------------------
--  3. Inserción de datos semilla
-- ---------------------------------------------------------------------------

-- --- Datos: planes ---
INSERT INTO planes (id_plan, nombre_plan, precio_mensual, descripcion, duracion_dias)
VALUES
    (1, 'Básico Mensual',    9.99,   'Acceso básico a funcionalidades estándar',  30),
    (2, 'Premium Mensual',   19.99,  'Acceso completo con características avanzadas', 30),
    (3, 'Básico Anual',      99.99,  'Plan anual con 2 meses gratis',              365),
    (4, 'Premium Anual',     199.99, 'Plan anual premium con descuento exclusivo', 365);
GO

-- --- Datos: suscriptores ---
INSERT INTO suscriptores (id_suscriptor, nombre, email, telefono, pais, fecha_registro)
VALUES
    (1, 'Ana García López',     'ana.garcia@email.com',     '+54 11 1234-5678', 'Argentina', '2025-01-15'),
    (2, 'Luis Martínez Ruiz',   'luis.martinez@email.com',  '+54 11 2345-6789', 'Argentina', '2025-02-20'),
    (3, 'María Fernández Díaz', 'maria.fernandez@email.com', '+34 91 123 4567', 'España',    '2025-03-10'),
    (4, 'Carlos Pérez Sánchez', 'carlos.perez@email.com',   '+1 55 9876-5432',  'México',    '2025-04-05'),
    (5, 'Sofia Rojas Torres',   'sofia.rojas@email.com',    '+56 9 8765-4321',  'Chile',     '2025-05-22'),
    (6, 'Diego Castillo Nova',  'diego.castillo@email.com', '+51 1 4321-5678',  'Perú',      '2025-06-18');
GO

-- --- Datos: suscripciones ---
INSERT INTO suscripciones (id_suscripcion, id_suscriptor, id_plan, fecha_inicio, fecha_fin, estado, metodo_pago)
VALUES
    (1, 1, 2, '2025-01-15', '2025-02-15', 'cancelada',   'tarjeta_credito'),
    (2, 2, 1, '2025-02-20', '2025-03-20', 'activa',      'tarjeta_debito'),
    (3, 3, 4, '2025-03-10', '2026-03-10', 'activa',      'tarjeta_credito'),
    (4, 4, 2, '2025-04-05', '2025-04-20', 'cancelada',   'transferencia'),
    (5, 5, 3, '2025-05-22', '2026-05-22', 'activa',      'tarjeta_credito'),
    (6, 6, 1, '2025-06-18', NULL,         'activa',      'tarjeta_debito'),
    (7, 2, 4, '2025-07-01', '2026-07-01', 'activa',      'tarjeta_credito'),
    (8, 1, 3, '2025-06-01', NULL,         'activa',      'transferencia');
GO

-- ---------------------------------------------------------------------------
--  4. Mensaje de confirmación
-- ---------------------------------------------------------------------------
PRINT 'Base de datos DB_Analisis_Suscripciones creada exitosamente.';
PRINT 'Tablas: planes, suscriptores, suscripciones.';
PRINT 'Datos semilla insertados: 4 planes, 6 suscriptores, 8 suscripciones.';
