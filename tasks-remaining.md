# Staging Environment - Tasks Remaining

All core blockers (Database connection, RLS Policies, and JWT Keys) have been resolved and verified on a fresh clone. All code and instructions have been pushed to the GitHub repository.

## 🚩 Completed Fixes (Verified)
- [x] **Database Connectivity**: Added `.env.example` and instructions for setup.
- [x] **RLS Policies**: Restored missing Prisma migrations to Git; `set_tenant_context` now works.
- [x] **JWT Security**: Created `scripts/generate-keys.js` and added `setup:keys` script.
- [x] **E2E Validation**: Full API test suite passed in a pristine destination clone.

## 📋 Outstanding Tasks

### 1. External & UI Team Verification
- Team needs to perform `git pull` on their local machines.
- Team must run exactly these commands once:
  ```bash
  copy .env.example .env
  copy packages\auth-bff\.env.example packages\auth-bff\.env
  npm run setup:keys
  ```
- Then restart the flow from Step 5 of the README.

### 2. Render Deployment (Phase 2)
- [ ] Create `_readme_docker_on_render.md` with step-by-step container deployment.
- [ ] Configure Environment Secret management for Render.
- [ ] Test Render-specific Docker networking (Postgres vs BFF).
- [ ] Provide production-ready database migration scripts for Render.

---
*Date: 2026-03-14*  
*Status: Staging Stable / Ready for Render Planning*
