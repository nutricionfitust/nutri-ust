-- Ya aplicada. Agrega las columnas que permiten el motor de sugerencia de
-- combinaciones de alimentos (puntos + proteína -> alimentos concretos,
-- filtrados por comida y rol nutricional).

alter table public.alimentos
  add column rol_meal text check (rol_meal in ('proteina','hc','grasa','vegetal_libre','lacteo','mixto')),
  add column comidas_validas text[];

comment on column public.alimentos.rol_meal is 'Rol nutricional funcional del alimento dentro de una comida (para el motor de sugerencia de combinaciones)';
comment on column public.alimentos.comidas_validas is 'Comidas del día donde este alimento es clínicamente apropiado: desayuno, almuerzo, merienda, cena, colacion';
