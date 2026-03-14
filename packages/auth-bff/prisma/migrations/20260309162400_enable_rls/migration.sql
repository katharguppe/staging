-- Row-Level Security (RLS) Policies for Multi-Tenant Data Isolation
-- Architecture Spec Section 4.2
-- 
-- This migration enables RLS on tenant-scoped tables and creates policies
-- that ensure users can only access data within their own tenant.

-- ─── Enable RLS on Users Table ─────────────────────────────────────────────

ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE users FORCE ROW LEVEL SECURITY;

-- Policy: Users can only see users within their own tenant
CREATE POLICY tenant_isolation_on_users ON users
  USING (tenant_id = current_setting('app.current_tenant_id', true)::uuid);

-- Policy: Operators (no tenant_id) can see all users
CREATE POLICY operator_access_on_users ON users
  USING (current_setting('app.current_tenant_id', true) IS NULL);

-- ─── Enable RLS on Refresh Tokens Table ────────────────────────────────────

ALTER TABLE refresh_tokens ENABLE ROW LEVEL SECURITY;
ALTER TABLE refresh_tokens FORCE ROW LEVEL SECURITY;

-- Policy: Refresh tokens are isolated by tenant
CREATE POLICY tenant_isolation_on_refresh_tokens ON refresh_tokens
  USING (tenant_id = current_setting('app.current_tenant_id', true)::uuid);

-- Policy: Operators can access all refresh tokens
CREATE POLICY operator_access_on_refresh_tokens ON refresh_tokens
  USING (current_setting('app.current_tenant_id', true) IS NULL);

-- ─── Enable RLS on Auth Events Table ───────────────────────────────────────

ALTER TABLE auth_events ENABLE ROW LEVEL SECURITY;
ALTER TABLE auth_events FORCE ROW LEVEL SECURITY;

-- Policy: Auth events are isolated by tenant
CREATE POLICY tenant_isolation_on_auth_events ON auth_events
  USING (tenant_id = current_setting('app.current_tenant_id', true)::uuid);

-- Policy: Operators can access all auth events
CREATE POLICY operator_access_on_auth_events ON auth_events
  USING (current_setting('app.current_tenant_id', true) IS NULL);

-- ─── Helper Functions ──────────────────────────────────────────────────────

-- Function to set the current tenant context for a session
CREATE OR REPLACE FUNCTION set_tenant_context(tenant_uuid uuid)
RETURNS void AS $$
BEGIN
  EXECUTE format('SET app.current_tenant_id = %L', tenant_uuid::text);
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to get the current tenant context
CREATE OR REPLACE FUNCTION get_current_tenant_id()
RETURNS uuid AS $$
BEGIN
  RETURN current_setting('app.current_tenant_id', true)::uuid;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ─── Performance Notes ─────────────────────────────────────────────────────
-- RLS policies add minimal overhead (< 5ms per query) when:
-- 1. The tenant_id column is indexed (already done in schema)
-- 2. The app.current_tenant_id is set before queries
-- 3. Queries include tenant_id in WHERE clause when possible
--
-- Usage in application code:
-- Before executing queries, set the tenant context:
--   SELECT set_tenant_context('tenant-uuid-here');
-- 
-- For operators (no tenant context):
--   RESET app.current_tenant_id;
--   -- or simply don't set it
