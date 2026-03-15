# 📊 PP2B - SATDPO

## Sistema de Alerta Temprana de Desempeño del Personal Operativo

Proyecto desarrollado para el curso **Big Data Aplicada** del
**Instituto Continental**.

El objetivo del proyecto es construir un **pipeline de datos** que
permita analizar información relacionada con el desempeño del personal
operativo y generar indicadores que faciliten la **detección temprana de
problemas de rendimiento**.

El sistema se basa en una **arquitectura moderna de datos tipo
Medallion**, donde los datos se procesan progresivamente desde datos
crudos hasta información analítica.

------------------------------------------------------------------------

# 🎯 Objetivo del proyecto

Desarrollar un sistema que permita:

-   Integrar múltiples fuentes de datos operativos.
-   Construir un **pipeline de procesamiento de datos**.
-   Preparar información para **análisis de desempeño del personal**.
-   Crear una base para **sistemas de alerta temprana basados en
    datos**.

------------------------------------------------------------------------

# 🏗 Arquitectura del Pipeline

El flujo de datos del proyecto sigue la siguiente arquitectura:

    GitHub Repository
            │
            ▼
    Python (Jupyter Notebook)
            │
            ▼
    Carga de datos
            │
            ▼
    Bronze Layer
            │
            ▼
    Silver Layer (pendiente)
            │
            ▼
    Gold Layer (pendiente)
            │
            ▼
    Supabase Database

Este enfoque permite:

-   mantener **trazabilidad de datos**
-   aplicar **transformaciones progresivas**
-   facilitar **análisis escalable**

------------------------------------------------------------------------

# 🥉 Bronze Layer (Actual)

La capa **Bronze** contiene los **datos crudos** provenientes de los
archivos fuente.

Características:

-   Datos sin transformar
-   Estructura original
-   Base del pipeline de datos

Actualmente esta capa se trabaja mediante el notebook:

    notebooks/carga_bronza.ipynb

Este notebook realiza:

-   lectura de archivos CSV
-   preparación inicial de datos
-   carga hacia la base de datos

------------------------------------------------------------------------

# 🥈 Silver Layer (Próximamente)

La capa **Silver** será implementada en las siguientes fases del
proyecto.

Procesos previstos:

-   limpieza de datos
-   validación de registros
-   normalización
-   eliminación de inconsistencias

Estado actual:

**🔄 Pendiente de implementación**

------------------------------------------------------------------------

# 🥇 Gold Layer (Próximamente)

La capa **Gold** contendrá datos **listos para análisis y
visualización**.

Se implementará un **modelo dimensional** basado en tablas de hechos y
dimensiones.

Estado actual:

**🔄 Pendiente de implementación**

------------------------------------------------------------------------

# 📂 Estructura del repositorio

    PP2B_SATDPO/
    │
    ├── .secrets/
    │   ├── db_config.py
    │   └── secrets.toml
    │
    ├── assets/
    │   └── docs/
    │
    ├── data/
    │   ├── 1_dim_asesor.csv
    │   ├── 2_fact_reclutamiento.csv
    │   ├── 3_fact_rendimiento_mensual.csv
    │   ├── 4_fact_capacitacion.csv
    │   ├── 5_fact_calidad.csv
    │   ├── 6_fact_incidencias.csv
    │   ├── 7_fact_adherencia.csv
    │   └── 8_fact_clima.csv
    │
    ├── notebooks/
    │   └── carga_bronza.ipynb
    │
    ├── venv_bda_idl2/
    │
    ├── .gitignore
    ├── README.md
    └── requirements.txt

------------------------------------------------------------------------

# 📊 Fuentes de datos

El sistema utiliza diferentes datasets relacionados con el desempeño
operativo.

  Archivo                        Descripción
  ------------------------------ -----------------------------------
  dim_asesor.csv                 Información del personal
  fact_reclutamiento.csv         Datos del proceso de contratación
  fact_rendimiento_mensual.csv   Indicadores de desempeño
  fact_capacitacion.csv          Registro de capacitaciones
  fact_calidad.csv               Evaluaciones de calidad
  fact_incidencias.csv           Registro de incidencias
  fact_adherencia.csv            Cumplimiento de horarios
  fact_clima.csv                 Indicadores de clima laboral

------------------------------------------------------------------------

# ⭐ Modelo dimensional (Planificado)

El modelo analítico utilizará un **esquema en estrella**.

                     dim_asesor
                         │
                         │
     ┌───────────────────┼────────────────────┐
     │                   │                    │
    fact_rendimiento   fact_calidad     fact_capacitacion
     │
    fact_incidencias
     │
    fact_adherencia
     │
    fact_clima

Este modelo permitirá:

-   análisis de desempeño por asesor
-   análisis temporal
-   análisis de indicadores operativos

------------------------------------------------------------------------

# ⚙️ Tecnologías utilizadas

  Tecnología         Uso
  ------------------ -------------------------
  Python             Procesamiento de datos
  Pandas             Transformación de datos
  Jupyter Notebook   Desarrollo del pipeline
  Supabase           Base de datos
  SQL                Consultas y modelado
  GitHub             Control de versiones

------------------------------------------------------------------------

# 🚀 Cómo ejecutar el proyecto

## 1 Clonar el repositorio

``` bash
git clone https://github.com/tu_usuario/PP2B_SATDPO.git
cd PP2B_SATDPO
```

------------------------------------------------------------------------

## 2 Crear entorno virtual

``` bash
python -m venv venv_bda_idl2
```

Activar entorno en Windows:

``` bash
venv_bda_idl2\Scripts\activate
```

------------------------------------------------------------------------

## 3 Instalar dependencias

``` bash
pip install -r requirements.txt
```

------------------------------------------------------------------------

## 4 Ejecutar notebook

Abrir:

    notebooks/carga_bronza.ipynb

Este notebook ejecuta la **carga inicial de datos hacia la capa
Bronze**.

------------------------------------------------------------------------

# 📈 Próximas etapas del proyecto

Las siguientes fases del proyecto incluirán:

-   Implementación de la **capa Silver**
-   Implementación de la **capa Gold**
-   Creación del **modelo dimensional**
-   Generación de **indicadores de desempeño**
-   Construcción de **dashboards analíticos**

------------------------------------------------------------------------

# 🎓 Contexto académico

Proyecto desarrollado para el curso:

**Big Data Aplicada**

Institución:

**Instituto Continental**

