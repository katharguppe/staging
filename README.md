# SaaS Auth (Staging Environment)

This is the staging environment copy of the **SaaS Multi-Tenant Authentication** project. It is set up as a standalone deployable package.

## Requirements

- Node.js 20+
- npm 10+
- Docker Desktop (for Postgres and Mailhog)

## Quick Start

1. **Install Dependencies**
   ```bash
   npm install
   ```

2. **Start Infrastructure (DB & Email)**
   ```bash
   npm run docker:up
   ```

3. **Database Setup**
   ```bash
   npm run db:migrate
   npm run db:seed
   ```

4. **Start Backend Service (Port 3001)**
   ```bash
   cd packages/auth-bff
   npm run dev
   ```

5. **Start Frontend Login UI (Port 5173)**
   ```bash
   cd packages/login-ui
   npm run dev
   ```

## Default Test Accounts

| Role | Email | Password | Tenant |
|------|-------|----------|--------|
| **Operator** | operator@yoursaas.com | Operator@Secure123! | system |
| **Admin** | admin@acme.com | Admin@Acme123! | acme-corp |
| **User** | alice@acme.com | User@Acme123! | acme-corp |

*See original repo documentation for full test account list and API tests.*
