# Supabase setup

Apply `migrations/20261022000000_shadowops_schema.sql` in the Supabase SQL Editor or with the Supabase CLI.

This migration creates `ops_nodes` and `activity_logs`, explicit Data API grants, indexes and row-level security policies. Operational logs are intentionally not exposed to anonymous visitors.

The frontend must never use the `service_role` key. Configure only the project URL and anon/publishable key in `config.json`. Complete Supabase Auth sign-in before enabling production writes.
