# Análisis de Suscripciones — SQL Server 2025

## Descripción

Sistema de gestión de suscripciones digitales (streaming, SaaS). Base de datos con
3 tablas relacionadas: planes, suscriptores y suscripciones.

Los scripts están organizados por nivel de complejidad: básico → joins → avanzado.

## Estructura

```
proyecto-final-suscripciones/
├── README.md
└── scripts/
    ├── 01_tablas_base.sql            ← CREATE DATABASE, CREATE TABLE, INSERT
    ├── 02_consultas_basicas.sql      ← SELECT, WHERE, ORDER BY, DISTINCT, LIKE
    ├── 03_joins.sql                  ← INNER, LEFT, RIGHT, FULL, CROSS JOIN
    └── 04_consultas_avanzadas.sql    ← GROUP BY, HAVING, subconsultas, CTE
```

## Modelo de datos

- **planes** — id_plan, nombre_plan, precio_mensual, descripcion, duracion_dias
- **suscriptores** — id_suscriptor, nombre, email, telefono, pais, fecha_registro
- **suscripciones** — id_suscripcion, id_suscriptor, id_plan, fecha_inicio, fecha_fin, estado, metodo_pago

Relación: suscriptores 1—< suscripciones >—N planes

## Tipos de dato

| Tipo | Columna de ejemplo |
|---|---|
| INT | id_suscriptor, id_plan |
| VARCHAR/NVARCHAR | nombre, email, nombre_plan |
| DECIMAL | precio_mensual |
| DATE | fecha_registro, fecha_inicio, fecha_fin |

Restricciones: PRIMARY KEY en cada tabla, NOT NULL en columnas obligatorias, FOREIGN KEY en suscripciones.

## Datos

| Tabla | Registros |
|---|---|
| planes | 4 |
| suscriptores | 6 |
| suscripciones | 8 |

## Cómo ejecutar

```bash
# 1. Crear base de datos y datos
sqlcmd -S localhost\SQLEXPRESS -G -N o -C -i scripts/01_tablas_base.sql

# 2. Consultas básicas
sqlcmd -S localhost\SQLEXPRESS -G -N o -C -i scripts/02_consultas_basicas.sql

# 3. Joins
sqlcmd -S localhost\SQLEXPRESS -G -N o -C -i scripts/03_joins.sql

# 4. Consultas avanzadas
sqlcmd -S localhost\SQLEXPRESS -G -N o -C -i scripts/04_consultas_avanzadas.sql
```

> Con autenticación SQL Server: `sqlcmd -S localhost\SQLEXPRESS -U sa -P "tu_password" -i scripts/...`

## Notas

- `01_tablas_base.sql` es idempotente (elimina y recrea la BD si existe).
- Ajusta `-S localhost\SQLEXPRESS` al nombre de tu instancia.
