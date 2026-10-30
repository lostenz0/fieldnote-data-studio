# Supabase account setup

The dashboard works without an account. This deployment is connected to its Supabase project for email sign-in and private saved datasets. Imported data is sent to Supabase only when a signed-in user imports it for account saving.

## Current deployment

For this deployment, the database schema is applied, email sign-up is enabled, email confirmation is required, and the Site URL and redirect allow-list include the GitHub Pages site. To create an account, choose **Sign in → Create an account** on the live site and confirm your email before signing in.

Supabase's default email service is limited to 2 emails per hour. Configure a custom SMTP provider under **Authentication → Emails → SMTP Settings** before opening sign-ups to a larger audience.

Each authenticated user can only read and save their own datasets because the table has Row Level Security policies scoped to their user ID.

## Connect a different Supabase project

1. In its SQL Editor, run [`supabase-schema.sql`](./supabase-schema.sql). It creates `public.analytics_datasets`, enables Row Level Security, and grants authenticated users access only to rows whose `user_id` matches their account ID.
2. Replace the Project URL and publishable (or legacy `anon`) key in `supabase-config.js` with that project's values. Publishable keys are intended for browser use. Never use a `service_role` or secret key, database password, or other private credential in frontend code.
3. In **Authentication → URL Configuration**, set the Site URL and Redirect URLs to the deployed site. Add the actual local origin too if you use a local static server.
4. Enable email sign-ups and configure custom SMTP if you need more than the default email rate limit.
5. Test account creation, email confirmation, sign-in, password reset, and dataset saving.

Never share Supabase secret keys or database passwords.
