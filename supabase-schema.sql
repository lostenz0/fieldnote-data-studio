create table if not exists public.analytics_datasets (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  name text not null check (char_length(name) between 1 and 120),
  data_rows jsonb not null check (jsonb_typeof(data_rows) = 'array'),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists analytics_datasets_user_updated_idx
  on public.analytics_datasets (user_id, updated_at desc);

alter table public.analytics_datasets enable row level security;

revoke all on public.analytics_datasets from anon, authenticated;
grant select, insert, update, delete on public.analytics_datasets to authenticated;

drop policy if exists "Users can read their own datasets" on public.analytics_datasets;
create policy "Users can read their own datasets"
  on public.analytics_datasets for select to authenticated
  using ((select auth.uid()) = user_id);

drop policy if exists "Users can create their own datasets" on public.analytics_datasets;
create policy "Users can create their own datasets"
  on public.analytics_datasets for insert to authenticated
  with check ((select auth.uid()) = user_id);

drop policy if exists "Users can update their own datasets" on public.analytics_datasets;
create policy "Users can update their own datasets"
  on public.analytics_datasets for update to authenticated
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);

drop policy if exists "Users can delete their own datasets" on public.analytics_datasets;
create policy "Users can delete their own datasets"
  on public.analytics_datasets for delete to authenticated
  using ((select auth.uid()) = user_id);
