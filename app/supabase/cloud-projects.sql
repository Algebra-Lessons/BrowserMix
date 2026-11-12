-- Run once in Supabase SQL Editor. Private user-owned projects and audio files.
create table if not exists public.browsermix_projects (
 id uuid primary key default gen_random_uuid(),
 user_id uuid not null references auth.users(id) on delete cascade,
 name text not null check (char_length(name) between 1 and 120),
 project_type text not null default 'sample' check (project_type in ('sample','scratch')),
 data jsonb not null default '{}'::jsonb,
 created_at timestamptz not null default now(),
 updated_at timestamptz not null default now()
);
create index if not exists browsermix_projects_user_id_idx on public.browsermix_projects(user_id, updated_at desc);
alter table public.browsermix_projects enable row level security;
drop policy if exists "Users can read their projects" on public.browsermix_projects;
create policy "Users can read their projects" on public.browsermix_projects for select to authenticated using ((select auth.uid())=user_id);
drop policy if exists "Users can create their projects" on public.browsermix_projects;
create policy "Users can create their projects" on public.browsermix_projects for insert to authenticated with check ((select auth.uid())=user_id);
drop policy if exists "Users can update their projects" on public.browsermix_projects;
create policy "Users can update their projects" on public.browsermix_projects for update to authenticated using ((select auth.uid())=user_id) with check ((select auth.uid())=user_id);
drop policy if exists "Users can delete their projects" on public.browsermix_projects;
create policy "Users can delete their projects" on public.browsermix_projects for delete to authenticated using ((select auth.uid())=user_id);
insert into storage.buckets (id,name,public,file_size_limit,allowed_mime_types)
values ('browsermix-audio','browsermix-audio',false,52428800,array['audio/mpeg','audio/mp3','audio/wav','audio/x-wav','audio/ogg','audio/mp4','audio/aac','audio/flac','application/octet-stream'])
on conflict (id) do nothing;
drop policy if exists "BrowserMix read own audio" on storage.objects;
create policy "BrowserMix read own audio" on storage.objects for select to authenticated using (bucket_id='browsermix-audio' and (storage.foldername(name))[1]=(select auth.uid())::text);
drop policy if exists "BrowserMix upload own audio" on storage.objects;
create policy "BrowserMix upload own audio" on storage.objects for insert to authenticated with check (bucket_id='browsermix-audio' and (storage.foldername(name))[1]=(select auth.uid())::text);
drop policy if exists "BrowserMix delete own audio" on storage.objects;
create policy "BrowserMix delete own audio" on storage.objects for delete to authenticated using (bucket_id='browsermix-audio' and (storage.foldername(name))[1]=(select auth.uid())::text);
