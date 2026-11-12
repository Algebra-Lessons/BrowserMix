# BrowserMix 2.0 (React + Vite)

This is the **development** app in `app/`. The root `index.html` remains the current production site. Existing BrowserSample and BrowserScratch are preserved in `app/public/legacy.html` and embedded temporarily while the audio engines are migrated to React.

## Development

```bash
cd app
npm install
npm run dev
```

Create `app/.env` using `.env.example` or configure Netlify environment variables `VITE_SUPABASE_URL` and `VITE_SUPABASE_PUBLISHABLE_KEY` (public client credentials only). Never commit service-role or secret keys.

## Netlify preview

Set **base directory** `app`, **build command** `npm run build`, **publish directory** `dist` for a *separate preview site*. Do not change the existing production Netlify configuration yet.

## Status

- React homepage and workspace navigation: implemented.
- Supabase email signup/login UI: implemented, requires configured keys and Auth redirect URLs.
- Existing sampler/DJ engines: preserved in iframe, **not yet migrated to React**.
- Cloud project saves and uploads: **not implemented**. Existing IndexedDB project data remains in the original browser origin; do not clear it.
- No database tables or storage buckets have been created by this change.
