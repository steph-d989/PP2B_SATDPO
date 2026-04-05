---- CREACION DEL ESQUEMA BONZE ----
CREATE SCHEMA bronze;

---- CREACION DE TABLAS EN ESQUEMA BRONZE ----
-- 1. Asesor
CREATE TABLE bronze.asesor (
    id_asesor VARCHAR(20) PRIMARY KEY,
    nombre_completo VARCHAR(150),
    modalidad_trabajo VARCHAR(50),
    edad INT,
    estado_civil VARCHAR(50),
    carga_familiar_hijos INT,
    distancia_oficina_km DECIMAL(5,2),
    experiencia_previa_meses INT,
    nivel_educativo VARCHAR(100),
    estado_actual VARCHAR(50)
);

-- 2. Reclutamiento
CREATE TABLE bronze.reclutamiento (
    id_asesor VARCHAR(20),
    puntaje_cv DECIMAL(5,2),
    score_entrevista DECIMAL(5,2),
    test_estres DECIMAL(5,2),
    test_empatia DECIMAL(5,2),
    perfil_riesgo_ingreso VARCHAR(50)
);

-- 3. Rendimiento_mensual
CREATE TABLE bronze.rendimiento_mensual (
    id_asesor VARCHAR(20),
    mes_gestion INT,
    tmo_promedio_min DECIMAL(5,2),
    fcr_porcentaje DECIMAL(5,2),
    nps_mensual DECIMAL(5,2),
    micro_ausentismos INT,
    horas_no_listo DECIMAL(5,2)
);

-- 4. Capacitacion
CREATE TABLE bronze.capacitacion (
    id_asesor VARCHAR(20),
    mes_gestion INT,
    tipo_intervencion VARCHAR(100),
    horas_invertidas INT,
    impacto_post VARCHAR(50)
);

-- 5. Calidad
CREATE TABLE bronze.calidad (
    id_asesor VARCHAR(20),
    mes_gestion INT,
    nota_auditoria DECIMAL(5,2),
    errores_criticos INT,
    respuesta_asesor VARCHAR(100)
);

-- 6. Incidencias
CREATE TABLE bronze.incidencias (
    id_asesor VARCHAR(20),
    mes_gestion INT,
    tipo_incidencia VARCHAR(150),
    gravedad INT,
    reclamo_formal VARCHAR(10)
);

-- 7. Adherencia
CREATE TABLE bronze.adherencia (
    id_asesor VARCHAR(20),
    mes_gestion INT,
    adherencia_pct DECIMAL(5,2),
    tardanza_min_total INT,
    exceso_pausas_min INT,
    desconexiones_sistema INT
);

-- 8. Clima
CREATE TABLE bronze.clima (
    id_asesor VARCHAR(20),
    mes_gestion INT,
    motivacion_1_10 INT,
    satisfaccion_jefe INT,
    comentario_clima TEXT
);