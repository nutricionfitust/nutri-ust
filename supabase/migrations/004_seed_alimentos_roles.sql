-- Ya aplicada. Clasificación por grupo de intercambio (no por alimento individual),
-- aprobada por Francisco el 11/07/2026 como punto de partida -- correcciones
-- puntuales (qué lácteos entran en cena, legumbres en desayuno vegetariano, etc.)
-- quedan pendientes para más adelante.
--
-- 219 de 241 alimentos quedaron clasificados. Los 22 restantes (bebidas,
-- bebidas-alc, suplementos, otros, generales) quedan sin rol a propósito:
-- no entran al armado automático de comidas.

update public.alimentos set rol_meal='proteina', comidas_validas=array['almuerzo','cena']
  where intercambio_grupo in ('carnes','pescados','pescados-blancos');

update public.alimentos set rol_meal='mixto', comidas_validas=array['almuerzo','cena']
  where intercambio_grupo='prot-veg';

update public.alimentos set rol_meal='proteina', comidas_validas=array['desayuno','almuerzo','merienda','colacion']
  where intercambio_grupo='huevo';

update public.alimentos set rol_meal='lacteo', comidas_validas=array['desayuno','merienda','colacion']
  where intercambio_grupo in ('lacteo-beb','lacteo-fir','lacteo-que','lacteo-semi');

update public.alimentos set rol_meal='mixto', comidas_validas=array['merienda','colacion']
  where intercambio_grupo='lacteo-queso-med';

update public.alimentos set rol_meal='hc', comidas_validas=array['desayuno','almuerzo','merienda','cena']
  where intercambio_grupo='cereales';

update public.alimentos set rol_meal='mixto', comidas_validas=array['almuerzo','cena']
  where intercambio_grupo='legumbres';

update public.alimentos set rol_meal='hc', comidas_validas=array['almuerzo','cena']
  where intercambio_grupo='veg-c';

update public.alimentos set rol_meal='hc', comidas_validas=array['desayuno','merienda','colacion']
  where intercambio_grupo in ('frutas-alta','frutas-baja','frutas-des');

update public.alimentos set rol_meal='vegetal_libre', comidas_validas=array['almuerzo','cena']
  where intercambio_grupo='veg-ab';

update public.alimentos set rol_meal='grasa', comidas_validas=array['desayuno','almuerzo','merienda','cena','colacion']
  where intercambio_grupo in ('aceites','lipidos','frutos-secos','semillas');

update public.alimentos set rol_meal='hc', comidas_validas=array[]::text[]
  where intercambio_grupo='azucares';

-- bebidas, bebidas-alc, suplementos, otros, generales: sin actualizar (rol_meal queda null)
