---- CREACION ESQUEMA GOLD ----
CREATE SCHEMA IF NOT EXISTS gold;

---- CREACION DE TABLAS GOLD ----
CREATE TABLE gold.dim_asesor (
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

CREATE TABLE gold.dim_tiempo (
    mes_gestion INT PRIMARY KEY,
    descripcion_mes VARCHAR(50)
);

CREATE TABLE gold.fact_reclutamiento (
    id_asesor VARCHAR(20) PRIMARY KEY,
    puntaje_cv DECIMAL(5,2),
    score_entrevista DECIMAL(5,2),
    test_estres DECIMAL(5,2),
    test_empatia DECIMAL(5,2),
    perfil_riesgo_ingreso VARCHAR(50),
    FOREIGN KEY (id_asesor) REFERENCES gold.dim_asesor(id_asesor)
);

CREATE TABLE gold.fact_desempeno_mensual (
    id_asesor VARCHAR(20),
    mes_gestion INT,
    tmo_promedio_min DECIMAL(5,2),
    fcr_porcentaje DECIMAL(5,2),
    nps_mensual DECIMAL(5,2),
    micro_ausentismos INT,
    horas_no_listo DECIMAL(5,2),
    horas_invertidas INT,
    nota_auditoria DECIMAL(5,2),
    errores_criticos INT,
    adherencia_pct DECIMAL(5,2),
    tardanza_min_total INT,
    exceso_pausas_min INT,
    desconexiones_sistema INT,
    motivacion_1_10 INT,
    satisfaccion_jefe INT,
    total_incidencias INT,
    gravedad_promedio DECIMAL(5,2),
    PRIMARY KEY (id_asesor, mes_gestion),
    FOREIGN KEY (id_asesor) REFERENCES gold.dim_asesor(id_asesor),
    FOREIGN KEY (mes_gestion) REFERENCES gold.dim_tiempo(mes_gestion)
);

---- SP GOLD ----
CREATE OR REPLACE FUNCTION gold.sp_load_dim_asesor()
RETURNS VOID AS $$
BEGIN
    TRUNCATE TABLE gold.dim_asesor CASCADE;

    INSERT INTO gold.dim_asesor
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
    FROM silver.asesor;
END;
$$ LANGUAGE plpgsql;
SELECT gold.sp_load_dim_asesor();

CREATE OR REPLACE FUNCTION gold.sp_load_dim_tiempo()
RETURNS VOID AS $$
BEGIN
    TRUNCATE TABLE gold.dim_tiempo CASCADE;

    INSERT INTO gold.dim_tiempo (mes_gestion, descripcion_mes)
    SELECT DISTINCT
        mes_gestion,
        'Mes ' || mes_gestion
    FROM (
        SELECT mes_gestion FROM silver.rendimiento_mensual
        UNION
        SELECT mes_gestion FROM silver.capacitacion
        UNION
        SELECT mes_gestion FROM silver.calidad
        UNION
        SELECT mes_gestion FROM silver.incidencias
        UNION
        SELECT mes_gestion FROM silver.adherencia
        UNION
        SELECT mes_gestion FROM silver.clima
    ) t;
END;
$$ LANGUAGE plpgsql;
SELECT gold.sp_load_dim_tiempo()

CREATE OR REPLACE FUNCTION gold.sp_load_fact_reclutamiento()
RETURNS VOID AS $$
BEGIN
    TRUNCATE gold.fact_reclutamiento CASCADE;

    INSERT INTO gold.fact_reclutamiento
    SELECT
        id_asesor,
        puntaje_cv,
        score_entrevista,
        test_estres,
        test_empatia,
        perfil_riesgo_ingreso
    FROM silver.reclutamiento;
END;
$$ LANGUAGE plpgsql;
SELECT gold.sp_load_fact_reclutamiento()

CREATE OR REPLACE FUNCTION gold.sp_load_fact_desempeno_mensual()
RETURNS VOID AS $$
BEGIN
    TRUNCATE gold.fact_desempeno_mensual CASCADE;

    INSERT INTO gold.fact_desempeno_mensual (
        id_asesor,
        mes_gestion,
        tmo_promedio_min,
        fcr_porcentaje,
        nps_mensual,
        micro_ausentismos,
        horas_no_listo,
        horas_invertidas,
        nota_auditoria,
        errores_criticos,
        adherencia_pct,
        tardanza_min_total,
        exceso_pausas_min,
        desconexiones_sistema,
        motivacion_1_10,
        satisfaccion_jefe,
        total_incidencias,
        gravedad_promedio
    )
    SELECT
        rm.id_asesor,
        rm.mes_gestion,
        rm.tmo_promedio_min,
        rm.fcr_porcentaje,
        rm.nps_mensual,
        rm.micro_ausentismos,
        rm.horas_no_listo,
        COALESCE(cap.horas_invertidas, 0) AS horas_invertidas,
        cal.nota_auditoria,
        cal.errores_criticos,
        adh.adherencia_pct,
        adh.tardanza_min_total,
        adh.exceso_pausas_min,
        adh.desconexiones_sistema,
        cli.motivacion_1_10,
        cli.satisfaccion_jefe,
        COALESCE(inc.total_incidencias, 0) AS total_incidencias,
        COALESCE(inc.gravedad_promedio, 0) AS gravedad_promedio
    FROM silver.rendimiento_mensual rm
    LEFT JOIN silver.capacitacion cap
        ON rm.id_asesor = cap.id_asesor
       AND rm.mes_gestion = cap.mes_gestion
    LEFT JOIN silver.calidad cal
        ON rm.id_asesor = cal.id_asesor
       AND rm.mes_gestion = cal.mes_gestion
    LEFT JOIN silver.adherencia adh
        ON rm.id_asesor = adh.id_asesor
       AND rm.mes_gestion = adh.mes_gestion
    LEFT JOIN silver.clima cli
        ON rm.id_asesor = cli.id_asesor
       AND rm.mes_gestion = cli.mes_gestion
    LEFT JOIN (
        SELECT
            id_asesor,
            mes_gestion,
            COUNT(*) AS total_incidencias,
            AVG(gravedad)::DECIMAL(5,2) AS gravedad_promedio
        FROM silver.incidencias
        GROUP BY id_asesor, mes_gestion
    ) inc
        ON rm.id_asesor = inc.id_asesor
       AND rm.mes_gestion = inc.mes_gestion;
END;
$$ LANGUAGE plpgsql;
SELECT gold.sp_load_fact_desempeno_mensual()