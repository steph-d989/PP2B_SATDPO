---- CREACION DE ESQUEMA SILVER ----
CREATE SCHEMA IF NOT EXISTS silver;

---- CREACION DE TABLAS ESQUEMA SILVER ----
-- 1. Asesor
CREATE TABLE silver.asesor (
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
CREATE TABLE silver.reclutamiento (
    id_asesor VARCHAR(20),
    puntaje_cv DECIMAL(5,2),
    score_entrevista DECIMAL(5,2),
    test_estres DECIMAL(5,2),
    test_empatia DECIMAL(5,2),
    perfil_riesgo_ingreso VARCHAR(50)
);

-- 3. Rendimiento_mensual
CREATE TABLE silver.rendimiento_mensual (
    id_asesor VARCHAR(20),
    mes_gestion INT,
    tmo_promedio_min DECIMAL(5,2),
    fcr_porcentaje DECIMAL(5,2),
    nps_mensual DECIMAL(5,2),
    micro_ausentismos INT,
    horas_no_listo DECIMAL(5,2)
);

-- 4. Capacitacion
CREATE TABLE silver.capacitacion (
    id_asesor VARCHAR(20),
    mes_gestion INT,
    tipo_intervencion VARCHAR(100),
    horas_invertidas INT,
    impacto_post VARCHAR(50)
);

-- 5. Calidad
CREATE TABLE silver.calidad (
    id_asesor VARCHAR(20),
    mes_gestion INT,
    nota_auditoria DECIMAL(5,2),
    errores_criticos INT,
    respuesta_asesor VARCHAR(100)
);

-- 6. Incidencias
CREATE TABLE silver.incidencias (
    id_asesor VARCHAR(20),
    mes_gestion INT,
    tipo_incidencia VARCHAR(150),
    gravedad INT,
    reclamo_formal VARCHAR(10)
);

-- 7. Adherencia
CREATE TABLE silver.adherencia (
    id_asesor VARCHAR(20),
    mes_gestion INT,
    adherencia_pct DECIMAL(5,2),
    tardanza_min_total INT,
    exceso_pausas_min INT,
    desconexiones_sistema INT
);

-- 8. Clima
CREATE TABLE silver.clima (
    id_asesor VARCHAR(20),
    mes_gestion INT,
    motivacion_1_10 INT,
    satisfaccion_jefe INT,
    comentario_clima TEXT
);

---- SP ESQUEMA SILVER ----
CREATE OR REPLACE FUNCTION silver.sp_load_asesor ()
RETURNS VOID AS $$
BEGIN
    TRUNCATE TABLE silver.asesor CASCADE;

    INSERT INTO silver.asesor
    SELECT
        id_asesor,
        nombre_completo,
        modalidad_trabajo,
        edad,
        estado_civil,
        carga_familiar_hijos,
        distancia_oficina_km,
        experiencia_previa_meses,
        nivel_educativo,
        estado_actual    
    FROM bronze.asesor;
END;
$$ LANGUAGE plpgsql;
SELECT silver.sp_load_asesor();
SELECT COUNT(*) AS total_silver FROM silver.asesor;

CREATE OR REPLACE FUNCTION silver.sp_load_reclutamiento ()
RETURNS VOID AS $$
BEGIN
    TRUNCATE TABLE silver.reclutamiento;

    INSERT INTO silver.reclutamiento
    SELECT
        id_asesor,
        puntaje_cv,
        score_entrevista,
        test_estres,
        test_empatia,
        perfil_riesgo_ingreso    
    FROM bronze.reclutamiento;
END;
$$ LANGUAGE plpgsql;
SELECT silver.sp_load_reclutamiento();
SELECT COUNT(*) AS total_silver FROM silver.reclutamiento;

CREATE OR REPLACE FUNCTION silver.sp_load_rendimiento_mensual ()
RETURNS VOID AS $$
BEGIN
    TRUNCATE TABLE silver.rendimiento_mensual;

    INSERT INTO silver.rendimiento_mensual
    SELECT
        id_asesor,
        mes_gestion,
        tmo_promedio_min,
        fcr_porcentaje,
        nps_mensual,
        micro_ausentismos,
        horas_no_listo    
    FROM bronze.rendimiento_mensual;
END;
$$ LANGUAGE plpgsql;
SELECT silver.sp_load_rendimiento_mensual();
SELECT COUNT(*) AS total_silver FROM silver.rendimiento_mensual;

CREATE OR REPLACE FUNCTION silver.sp_load_capacitacion ()
RETURNS VOID AS $$
BEGIN
    TRUNCATE TABLE silver.capacitacion;

    INSERT INTO silver.capacitacion
    SELECT
        id_asesor,
        mes_gestion,
        tipo_intervencion,
        horas_invertidas,
        impacto_post
    FROM bronze.capacitacion;
END;
$$ LANGUAGE plpgsql;
SELECT silver.sp_load_capacitacion();
SELECT COUNT(*) AS total_silver FROM silver.capacitacion;

CREATE OR REPLACE FUNCTION silver.sp_load_calidad ()
RETURNS VOID AS $$
BEGIN
    TRUNCATE TABLE silver.calidad;

    INSERT INTO silver.calidad
    SELECT
        id_asesor,
        mes_gestion,
        nota_auditoria,
        errores_criticos,
        respuesta_asesor
    FROM bronze.calidad;
END;
$$ LANGUAGE plpgsql;
SELECT silver.sp_load_calidad();
SELECT COUNT(*) AS total_silver FROM silver.calidad;

CREATE OR REPLACE FUNCTION silver.sp_load_incidencias ()
RETURNS VOID AS $$
BEGIN
    TRUNCATE TABLE silver.incidencias;

    INSERT INTO silver.incidencias
    SELECT
        id_asesor,
        mes_gestion,
        tipo_incidencia,
        gravedad,
        reclamo_formal
    FROM bronze.incidencias;
END;
$$ LANGUAGE plpgsql;
SELECT silver.sp_load_incidencias();
SELECT COUNT(*) AS total_silver FROM silver.incidencias;

CREATE OR REPLACE FUNCTION silver.sp_load_adherencia ()
RETURNS VOID AS $$
BEGIN
    TRUNCATE TABLE silver.adherencia;

    INSERT INTO silver.adherencia
    SELECT
        id_asesor,
        mes_gestion,
        adherencia_pct,
        tardanza_min_total,
        exceso_pausas_min,
        desconexiones_sistema
    FROM bronze.adherencia;
END;
$$ LANGUAGE plpgsql;
SELECT silver.sp_load_adherencia();
SELECT COUNT(*) AS total_silver FROM silver.adherencia;

CREATE OR REPLACE FUNCTION silver.sp_load_clima ()
RETURNS VOID AS $$
BEGIN
    TRUNCATE TABLE silver.clima;

    INSERT INTO silver.clima
    SELECT
        id_asesor,
        mes_gestion,
        motivacion_1_10,
        satisfaccion_jefe,
        comentario_clima
    FROM bronze.clima;
END;
$$ LANGUAGE plpgsql;
SELECT silver.sp_load_clima();
SELECT COUNT(*) AS total_silver FROM silver.clima;