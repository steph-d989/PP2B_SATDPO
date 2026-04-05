---- CREACIÓN ESQUEMA META ----
CREATE SCHEMA IF NOT EXISTS meta;

---- 1. Pipeline_config
CREATE TABLE meta.pipeline_config(
    table_name TEXT PRIMARY KEY,
    load_type CHAR(1),
    last_load TIMESTAMP
)

---- INSERTAR DATOS EN PIPELINE
INSERT INTO meta.pipeline_config VALUES
('asesor', 'H', NOW()),
('reclutamiento', 'H', NOW()),
('rendimiento_mensual', 'H', NOW()),
('capacitacion', 'H', NOW()),
('calidad', 'H', NOW()),
('incidencias', 'H', NOW()),
('adherencia', 'H', NOW()),
('clima', 'H', NOW());
