# SaaS Auth staging - UI Team Setup Guide

This guide is specifically for the UI team to ensure you are pulling from the correct repository and setting things up correctly.

## 🛑 STOP! Are you in the right place?

Make sure you are cloning the **staging** repository, NOT the main components repository.

## Step 1: Clone the Correct Repository

Open your terminal or command prompt and run exact this command:

```bash
git clone https://github.com/katharguppe/staging.git
```

This will create a `staging` folder. 

## Step 2: Navigate into the folder

```bash
cd staging
```

## Step 3: Install Dependencies

```bash
npm install
```

## Step 4: Start the Infrastructure

You must have Docker Desktop running first!

```bash
npm run docker:up
```

## Step 5: Setup the Database

```bash
npm run db:migrate
npm run db:seed
```

## Step 6: Start the Backend (API)

```bash
cd packages/auth-bff
npm run dev
```

*(Leave this terminal window open!)*

## Step 7: Start the Frontend (UI)

Open a **NEW** terminal window:

```bash
cd packages/login-ui
npm run dev
```

The UI will now be available at: **http://localhost:5173**

---

### Test Accounts Available:

| Role | Email | Password | Tenant |
|------|-------|----------|--------|
| **Admin** | admin@acme.com | Admin@Acme123! | acme-corp |
| **User** | alice@acme.com | User@Acme123! | acme-corp |
