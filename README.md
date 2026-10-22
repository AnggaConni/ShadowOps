# International Shadow Ops System (ISO)

Strategic Operations Map & Daily Activity Tracker

> "No more blame games. Just data."

## Overview
ShadowOps combines hierarchy tracking with day-to-day operational logs. Its frontend now has a configurable data layer: it runs from local dummy data today and can be switched to Supabase when the project is ready.

## Features
- Interactive hierarchy tree with zoom, pan, status indicators, and budget labels.
- Activity logging through Manual Entry or AI Smart Log input (AI parsing is still a placeholder).
- Data-driven KPI summary, regional activity budget, and priority-risk list.
- Configurable data provider: `dummy.json` or Supabase.
- Supabase SQL migration with explicit Data API grants and row-level security (RLS).

## Run locally
Serve the repository over HTTP, for example with VS Code Live Server. Opening `index.html` through `file://` may block requests for `config.json` and `dummy.json`.

## Configure the source
Edit `config.json`.

- Keep `dataProvider: "dummy"` for the current mockup.
- When Supabase is ready, change it to `"supabase"` and fill in `supabase.url` and `supabase.anonKey`.
- The browser must use only the anon/publishable key. Never include the `service_role` key in frontend files.
- `dummy.json` contains illustrative demo records, not actual operational data.
- Dummy log submissions are stored in this browser's `localStorage`.

## Supabase setup
1. Run `supabase/migrations/20261022000000_shadowops_schema.sql` in Supabase SQL Editor or using the Supabase CLI.
2. Seed `public.ops_nodes` with one record per hierarchy node. `parent_id` forms the tree. Keep IDs stable (e.g. `shadowops-hq`, `region-asean`, and `activity-living-heritage`).
3. Enable a sign-in method in Supabase Auth and add a real sign-in UI before enabling live log writes.
4. Set `dataProvider` to `"supabase"` in `config.json`.

### Schema
- `ops_nodes`: hierarchy nodes, parent-child relationships, type, status, budgets and badges.
- `activity_logs`: activity logs, user identity, date, status, amount in USD, optional parsed AI JSON and evidence storage path.
- The frontend adapter translates the normalized table rows to the tree structure the UI expects.

### Explicit grants and RLS
The migration explicitly grants:
- `anon`: SELECT on `public.ops_nodes` only.
- `authenticated`: SELECT/INSERT/UPDATE/DELETE on both tables, subject to RLS. Log rows are scoped to their owning authenticated user in the starter policy.
- `service_role`: all table privileges for server-side use only.

The log table is not anonymously readable. RLS stays enabled and limits log writes to the authenticated owner. The current header identity is mock UI only; never treat it as authentication. The frontend retrieves the current Supabase Auth user before inserting a log.

## Current limitations
- AI Smart Log stores raw text; it does not call an AI service.
- Evidence upload UI is a placeholder; only a future `evidence_path` column is included.
- Live hierarchy data must be seeded into Supabase after the migration is applied.
