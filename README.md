# Fieldnote | Data Studio

Fieldnote is a lightweight, responsive CSV dashboard. Import a file to explore summary metrics, charts, and searchable rows. The sample dashboard is ready on first load, and imported data stays in the current browser tab unless you explicitly sign in to a Supabase project you configured.

## Features

- Overview, Explore data, Your data, and User manual views
- Line and bar charts, summary metrics, and selectable last 3/6 **rows**
- CSV import by file picker or drag and drop, with validation and safe text rendering
- Search table rows and export the complete current dataset to CSV or a printable PDF report
- English, Urdu, Hindi, Arabic, Spanish, and French; Urdu and Arabic use right-to-left layout
- PKR display by default, with a saved PKR/USD display-currency selector
- Light and dark themes; language, currency, and theme preferences are remembered in this browser
- Optional Supabase authentication and private saved datasets

The sample dashboard, local CSV import, charts, search, CSV export, and PDF report work without an account. PDF export opens a print dialog; choose **Save as PDF** to download the report. Email sign-in and private saved datasets are connected to the project's Supabase instance. Imported data is sent to Supabase only when a signed-in user imports it for account saving.

The app formats monetary columns in Pakistani rupees (PKR) by default. Choose USD from the currency menu to change the display. This changes formatting only; it does not convert values or fetch exchange rates. Make sure imported monetary values are already in the selected currency.

## Run locally

1. Open this folder in VS Code.
2. Open `index.html` in a browser, or use a static preview such as the VS Code Live Server extension.
3. Keep an internet connection available for the CDN-hosted Chart.js, PapaParse, Supabase client, Lucide icons, and Google Fonts.

No Python, Node.js, build step, or backend server is required for the dashboard. A local static server is useful for testing URL hashes and optional authentication redirects.

## CSV format

- Use a `.csv` file no larger than 5 MB.
- Put a name in every column header and include at least one data row.
- Keep each data row the same length as the header. Duplicate header names are renamed automatically.
- Numeric values are used for metrics and charts; other values are displayed as text.
- The 3/6 row selector uses the file's current row order; it does not detect or filter dates.
- Imported content is rendered as text. It is not treated as HTML or script.

## Dependencies

The page loads these browser libraries from public CDNs: Chart.js, PapaParse, Supabase JS, and Lucide. Google Fonts are also loaded remotely. There is no package manager or local build output.

## Optional Supabase setup

The deployed `supabase-config.js` is configured for this project's Supabase instance. To connect a different project:

1. Create a Supabase project.
2. In its SQL Editor, run [`supabase-schema.sql`](./supabase-schema.sql). It creates the `analytics_datasets` table and enables Row Level Security policies restricting each authenticated user to rows with their own `user_id`.
3. Replace the Project URL and publishable (or legacy `anon`) key in `supabase-config.js` with that project's values. Publishable keys are intended for browser use; never put a `service_role` or secret key in frontend code.
4. Configure Supabase Authentication's Site URL and Redirect URLs for your deployed site.

For this deployment, email sign-up and confirmation are enabled, the GitHub Pages redirect is configured, and the database schema is applied. Create an account on the live site and confirm your email before signing in. Supabase's default email service is limited to 2 emails per hour; configure a custom SMTP provider for wider public use.

The app remains usable without an account. Each authenticated user can only read and save their own datasets because the database table has Row Level Security policies scoped to their user ID. Never share Supabase secret keys or database passwords.

For detailed Supabase steps, see [`SUPABASE-SETUP.md`](./SUPABASE-SETUP.md).

## Deploy with GitHub Pages

1. Create a GitHub repository and add this project's root files (including `index.html`, `favicon.svg`, `supabase-config.js`, and `supabase-schema.sql`). Do not upload secrets or personal CSV data.
2. On GitHub, open **Settings → Pages**.
3. Under **Build and deployment**, choose **Deploy from a branch**, select your branch (commonly `main`) and the **/(root)** folder, then save.
4. Wait for the Pages deployment to finish. Open the URL GitHub shows; the relative `./favicon.svg` asset works from a repository-root Pages site.
5. If you connect Supabase, add that exact Pages URL to its Authentication Site URL and Redirect URLs, then test the account flows there.

This project is published from the `main` branch's root folder at <https://lostenz0.github.io/fieldnote-data-studio/>.
