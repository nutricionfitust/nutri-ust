-- Ya aplicada contra el proyecto de Supabase de NutriUst (ebtxzmwsuzzfkamxteyg).
-- Este archivo es un registro/documentación, no un instalador.

create table public.carpetas_recursos (
  id uuid primary key default gen_random_uuid(),
  nutricionista_id uuid not null references public.nutricionistas(id),
  nombre text not null,
  orden smallint not null default 0,
  created_at timestamptz not null default now()
);

alter table public.carpetas_recursos enable row level security;

create policy carpetas_recursos_nutri on public.carpetas_recursos
  for all
  using (nutricionista_id = auth.uid())
  with check (nutricionista_id = auth.uid());

create policy carpetas_recursos_consultante_read on public.carpetas_recursos
  for select
  using (nutricionista_id in (select nutricionista_id from public.consultantes where auth_user_id = auth.uid()));

create table public.recursos (
  id uuid primary key default gen_random_uuid(),
  nutricionista_id uuid not null references public.nutricionistas(id),
  carpeta_id uuid references public.carpetas_recursos(id),
  titulo text not null,
  descripcion text,
  contenido jsonb not null default '{"bloques": []}'::jsonb,
  origen_canva_id text,
  activo boolean not null default true,
  orden smallint not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.recursos enable row level security;

create policy recursos_nutri on public.recursos
  for all
  using (nutricionista_id = auth.uid())
  with check (nutricionista_id = auth.uid());

create policy recursos_consultante_read on public.recursos
  for select
  using (
    activo = true
    and nutricionista_id in (select nutricionista_id from public.consultantes where auth_user_id = auth.uid())
  );
