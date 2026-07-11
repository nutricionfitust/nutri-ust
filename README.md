# NutriUst — Biblioteca de Recursos (Nutrición Deportiva)

Sistema para que los consultantes de nutrición de Francisco Ustarroz (NutriciónFit UST /
@nutricionfitust) accedan, con su propio login, a los materiales educativos y a su plan
nutricional individual — hoy dispersos en Canva/PDF — en un formato web navegable, con la
estética de marca, navegación por índice y exportación a PDF (pendiente de conectar).

## Decisión de arquitectura

- **Vive en el proyecto de Supabase de NutriUst** (`ebtxzmwsuzzfkamxteyg`), no en un proyecto
  nuevo. Motivo: comparte identidad de consultante (un solo login) y el motor de planes que
  ya existe ahí (`planes_alimentacion`), evitando una migración de datos más adelante.
- **Frontend en repo propio**, separado del código grande de NutriUst — permite avanzar rápido
  sin depender del resto del roadmap de NutriUst (Antropometría, Otter IA, etc.).

## Estructura de contenido (carpetas que ve el consultante)

- **Nutrición Deportiva**: "Alimentación y Rendimiento Deportivo" (compartido, igual para
  todos) + "Planificación Nutricional" (individual, un documento distinto por consultante —
  ejemplos reales ya identificados: Ayrton Utrera, David Fuentealba, Ezequiel Ramirez, Jorge
  Mas, Juan Ignacio Ciocca, Marcelo Amitrano).
- **Herramientas**: Guía de Suplementos, Guía de Etiquetado, Ideas de Comidas Transportables,
  Porciones de Intercambio, Sistema de Puntos de Carbohidratos — todos compartidos.
- **Hábitos & Estilo de Vida**: carpeta creada, sin contenido todavía — a futuro también será
  individual por consultante (patrón "HÁBITOS" ya identificado en Drive).
- A futuro, todavía sin carpeta asignada: la línea "Planificación a Punto"
  (déficit/mantenimiento/superávit), individual por consultante.

## Modelo de datos (Supabase, proyecto `ebtxzmwsuzzfkamxteyg`)

- `carpetas_recursos` — carpetas por nutricionista.
- `recursos` — contenido en bloques (`contenido` jsonb: heading/párrafo/lista/callout/xlink),
  con `consultante_id` **nullable**: `null` = compartido para todos los consultantes de ese
  nutricionista, seteado = individual para un consultante puntual.
- `alimentos` — las 241 entradas del sistema de intercambio argentino ya existían; se sumaron
  `rol_meal` (proteina/hc/grasa/vegetal_libre/lacteo/mixto) y `comidas_validas`
  (desayuno/almuerzo/merienda/cena/colacion) para el motor de sugerencia de combinaciones.
  219/241 clasificados por grupo de intercambio (ver `004_seed_alimentos_roles.sql`); 22
  quedan sin rol a propósito (bebidas, suplementos, "otros").

## Estado actual

- [x] Esquema en Supabase (tablas + RLS) aplicado
- [x] 241 alimentos cargados, 219 clasificados por rol/comida (borrador aprobado, matices
      finos pendientes)
- [x] Prototipo de lectura completo de "Alimentación y Rendimiento Deportivo" (15 secciones
      reales, índice navegable, links externos funcionando, tema claro con difuminado de marca)
- [x] Prototipo de navegación por carpetas
- [ ] Auth real de consultantes (login mail + contraseña) — no conectado todavía
- [ ] Wiring del HTML a Supabase — hoy el contenido está escrito directo en el HTML, no viene
      de la base
- [ ] Ingesta de Herramientas (Suplementos, Etiquetado, Comidas Transportables, Porciones,
      Sistema de Puntos) — todavía no estructurados en bloques
- [ ] Motor de sugerencia de combinaciones (puntos + proteína → alimentos concretos por
      comida) — depende de que Francisco corrija matices de la clasificación
- [ ] Link real de la mini-app de Timing (`timings-nutricionales.vercel.app`) — pendiente que
      Francisco lo confirme
- [ ] Exportación real a PDF — hoy el botón no está conectado

## ⚠️ Importante sobre `supabase/migrations/`

Estas 4 migraciones **ya fueron aplicadas** contra el proyecto `ebtxzmwsuzzfkamxteyg`. Esta
carpeta es un registro para versionado y referencia, **no un instalador**: si las corrés tal
cual contra ese mismo proyecto van a fallar porque las tablas ya existen. Solo correrían de
punta a punta si en algún momento se arma un proyecto de Supabase distinto (por ejemplo, uno
de desarrollo/testing).

## Marca

- Colores: `#0072FB` (primario), `#6EA4FB` / `#99C5FF` (secundarios), fondo claro con
  difuminado celeste-azul-blanco (no navy oscuro).
- Tipografías: Plus Jakarta Sans (texto), DM Mono (labels / mono).
- Terminología: "consultante", nunca "paciente".
- Instagram: [@nutricionfitust](https://www.instagram.com/nutricionfitust)

## Próximo paso sugerido

Conectar `prototypes/plan_nutricional_reader.html` a Supabase de verdad: mover el contenido
hardcodeado a filas reales en `recursos`, y armar el login de consultante contra
`consultantes.auth_user_id`.
