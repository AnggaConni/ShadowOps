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
- `activity_logs`: activity logs, user identity, date, status, amount in USD, optional parsed AI JSON and evidence storage path. The starter UI loads logs only after a Supabase Auth session is present.
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
## Enriched UNESCO-inspired demo data

The current `dummy.json` demonstrates three fictional programme units: **Education**, **Natural Sciences**, and **Culture**. Each unit contains thematic workstreams, activities, budgets, statuses, and dated operational logs (60 logs across the hierarchy).

**Important provenance note:** this is a synthetic UX/testing dataset, not an official UNESCO organisation chart or a register of UNESCO projects, allocations, expenses, decisions, or field events. Public UNESCO pages are referenced only for broad thematic inspiration. No real programme allocation or operational record is claimed. Every log includes a `provenance` object that marks it as `synthetic_demo`, unverified, and without an external evidence reference. The top-level `_meta.dataProvenance` documents sources, method, and limitations.

For production use, replace the dummy records with approved source data, retain source URLs and evidence references at record level, and validate permissions before publishing sensitive community or heritage information.

## Operations dashboard overhaul (October 2026)

The executive dashboard now focuses on current delivery state and management action rather than treating every historical log as a current critical issue. It includes:

- Portfolio overview KPIs for planned activity budget, tracked activities, current issues and delays.
- Delivery-health distribution for On Track, Delayed, Issue and Completed activities.
- Search and status filters to narrow the management-attention list.
- Budget distribution by unit and a concise Capture → Validate → Review & Decide → Publish & Learn reporting flow.
- Clear warnings that the included figures are synthetic demo values, not official allocations, expenditure or verified results.

The demo activity records now carry explicit current status, a fictional progress percentage, a fictional due date and a simple illustrative risk level. Historical log status is retained as history; it must not be used as the sole basis for inferring the current activity status. These fields are for prototype UI testing and are not yet a production-grade indicator, financial or risk register.
