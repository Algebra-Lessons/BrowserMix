# BrowserMix cloud project saving — setup

This feature is developed on top of **feature/native-react-workstations** and does not affect production until reviewed and merged.

1. In Supabase Dashboard → SQL Editor, run `app/supabase/cloud-projects.sql`. This creates a private `browsermix_projects` table and `browsermix-audio` storage bucket with owner-only RLS policies.
2. Ensure Netlify development site has `VITE_SUPABASE_URL` and `VITE_SUPABASE_PUBLISHABLE_KEY`. Do not expose service-role keys.
3. Merge this PR into the native React workstation branch, then merge/update the React development branch when QA is complete.
4. Sign in, load an audio file into BrowserSample, create chops, select **Save to Cloud**, then **My Projects** to reload it.
5. Verify isolation with a second test account and check saving, loading, deleting, signout, and 50MB upload limits.

**Current limitations:** Only BrowserSample audio uploads and chop markers/pad settings are persisted. Sequencer steps, drums, custom themes, DJ mixes, advanced effects and Classic IndexedDB projects are not yet migrated. The upload file is capped at 50 MB. Supabase Free storage quotas apply. Cloud projects are private to their owners; users must have an authenticated session. No data migration or destructive operations are run automatically.

**Testing:** The code has not yet been built or exercised in a browser. Keep the PR as draft until build and audio/storage tests pass.
