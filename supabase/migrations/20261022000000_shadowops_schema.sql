-- ShadowOps Supabase schema migration
-- Apply in Supabase SQL Editor or via Supabase CLI.
-- Do not put the service_role key into frontend config.

create extension if not exists pgcrypto;

create table if not exists public.ops_nodes (
  id text primary key,
  parent_id text null references public.ops_nodes(id) on delete cascade,
  name text not null,
  node_type text not null check (node_type in ('HQ', 'Regional', 'Theme', 'Focal', 'Activity')),
  owner_name text not null default '',
  status text not null default 'On Track' check (status in ('On Track', 'Delayed', 'Issue', 'Completed')),
  budget_usd numeric(14,2) not null default 0 check (budget_usd >= 0),
  badges text[] not null default '{}',
  description text not null default '',
  sort_order integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists public.activity_logs (
  id uuid primary key default gen_random_uuid(),
  activity_id text not null references public.ops_nodes(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  user_email text not null default '',
  log_date date not null default current_date,
  status_update text not null default 'On Track'
    check (status_update in ('On Track', 'Delayed', 'Issue', 'Completed')),
  description text not null,
  amount_usd numeric(14,2) not null default 0 check (amount_usd >= 0),
  ai_parsed_json jsonb not null default '{}'::jsonb,
  evidence_path text null,
  created_at timestamptz not null default now()
);

create index if not exists ops_nodes_parent_sort_idx on public.ops_nodes(parent_id, sort_order);
create index if not exists activity_logs_activity_date_idx on public.activity_logs(activity_id, log_date desc, created_at desc);
create index if not exists activity_logs_user_id_idx on public.activity_logs(user_id);

alter table public.ops_nodes enable row level security;
alter table public.activity_logs enable row level security;

-- Explicit Data API grants for tables created after the Oct 30, 2026 change.
grant usage on schema public to anon, authenticated, service_role;
grant select on public.ops_nodes to anon;
grant select, insert, update, delete on public.ops_nodes to authenticated;
grant all privileges on public.ops_nodes to service_role;
grant select, insert, update, delete on public.activity_logs to authenticated;
grant all privileges on public.activity_logs to service_role;

drop policy if exists "Public can read ops nodes" on public.ops_nodes;
create policy "Public can read ops nodes" on public.ops_nodes
  for select to anon, authenticated using (true);

drop policy if exists "Authenticated users manage ops nodes" on public.ops_nodes;
create policy "Authenticated users manage ops nodes" on public.ops_nodes
  for all to authenticated using (auth.uid() is not null)
  with check (auth.uid() is not null);

drop policy if exists "Authenticated users read activity logs" on public.activity_logs;
create policy "Authenticated users read activity logs" on public.activity_logs
  for select to authenticated using (auth.uid() = user_id);

drop policy if exists "Users insert their own activity logs" on public.activity_logs;
create policy "Users insert their own activity logs" on public.activity_logs
  for insert to authenticated with check (auth.uid() = user_id);

drop policy if exists "Users update their own activity logs" on public.activity_logs;
create policy "Users update their own activity logs" on public.activity_logs
  for update to authenticated using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "Users delete their own activity logs" on public.activity_logs;
create policy "Users delete their own activity logs" on public.activity_logs
  for delete to authenticated using (auth.uid() = user_id);
