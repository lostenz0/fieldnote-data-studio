# Optional Supabase account setup

The dashboard works without an account. If you choose to enable accounts, Supabase stores datasets only after a user signs in to the project configured in this browser app. No Supabase credentials are included here.

1. Create a Supabase project.
2. In the Supabase SQL Editor, run [`supabase-schema.sql`](./supabase-schema.sql). It creates `public.analytics_datasets`, enables Row Level Security, and grants authenticated users access only to rows whose `user_id` matches their account ID.
3. In Project Settings → API, copy the Project URL and the publishable key (or legacy `anon` key) into `supabase-config.js`, replacing the placeholders. Do not use a `service_role` key, secret key, password, or other private credential in frontend code.
4. In Authentication → URL Configuration, set the Site URL and Redirect URLs to your local site and the deployed GitHub Pages URL. For a local static preview, use that preview's actual origin.
5. Reload Fieldnote and test account creation, email confirmation, sign-in, password reset, and dataset saving with your own project.

The example config is intentionally unconfigured, so authentication and saved datasets are not enabled by default. When you select Sign in without valid setup, the app explains what configuration is required. Do not rely on account features until you have tested them against your own Supabase project.

Imported data works locally without Supabase. It is sent to Supabase only when a configured user is signed in and chooses to import data for account saving.
