-- Ya aplicada. Agrega el soporte para recursos individuales por consultante
-- (ej: el documento "Planificación Nutricional" de cada persona), a diferencia
-- de los recursos compartidos (consultante_id = null = visible para todos
-- los consultantes de ese nutricionista).

alter table public.recursos
  add column consultante_id uuid references public.consultantes(id);

create index recursos_consultante_id_idx on public.recursos(consultante_id);

alter policy recursos_consultante_read on public.recursos
  using (
    activo = true
    and nutricionista_id in (select nutricionista_id from public.consultantes where auth_user_id = auth.uid())
    and (
      consultante_id is null
      or consultante_id in (select id from public.consultantes where auth_user_id = auth.uid())
    )
  );
