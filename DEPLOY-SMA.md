# Linkwarden — Deploy / SMA

## Baseline

| Key | Value |
|-----|-------|
| Fork | `https://github.com/Smartesting/linkwarden` |
| Upstream | `https://github.com/linkwarden/linkwarden` |
| Baseline ref | `22723575b04503eb67c9733c63d55179c069903d` |
| Branch | `tester-env-baseline` |

## Deploy

```sh
./tester-env reset
./tester-env deploy --ref 22723575b04503eb67c9733c63d55179c069903d
```

- Builds from source (Dockerfile in repo root; `build: .` in docker-compose.yml).
- Starts Postgres 16-alpine + Meilisearch v1.12.8 + Linkwarden (Next.js production build).
- Serves at `http://localhost:3100/` (configurable via `PORT` env).
- Deterministic `.env` written by `write_env()` in tester-env script.
- Credentials: `tester` / `tester-env-secure-password`.
- Cold build ~15 min; incremental source-only rebuild ~6–7 min.

## Seed

```sh
./tester-env seed
```

Theme: **Northstar Product Lab** bookmark workspace.

Fixtures:
- 1 user: `tester`
- 5 collections (Design System nested under Product Research; Release Planning nested under Engineering Notes)
- 12 links with stable UUIDs
- 9 tags
- 3 pinned links
- 5 dashboard sections
- All timestamps fixed for determinism
- Meilisearch indexVersion=1 for all links

## Verify

```sh
./tester-env verify
```

Checks:
- Postgres counts: 1 user, 5 collections, 12 links, 9 tags, 3 pinned links
- Collection names and parent-child nesting
- Pinned link names
- Unique search phrase `vector-retrospective` returns exactly 1 result
- Meilisearch `indexVersion=1` for all 12 links
- Credential login endpoint returns 200/302
- Served `/links` page does NOT contain `MUTATED Links` (mutation-smoke absence)

## Reset

```sh
./tester-env reset
```

Stops compose project and removes `pgdata/`, `data/`, `meili_data/` bind-mounted directories via alpine container.

## Browser Evidence (data_seed)

Performed by browser-checker subagent after `./tester-env deploy && ./tester-env seed`:

- Login with `tester` / `tester-env-secure-password` succeeded.
- Dashboard stats: Links=12, Collections=5, Tags=9, Pinned=3.
- Recent Links and Pinned Links sections populated with realistic entries.
- Collections page showed top-level: Engineering Notes, Market Intel, Product Research; nested: Design System (under Product Research), Release Planning (under Engineering Notes).
- All Links heading reads baseline `All Links` with 12 realistic link cards visible.
- No `MUTATED Links` text observed anywhere.
- Tags page showed 9 tags with link counts.
- Search for `vector-retrospective` returned 1 result: `Customer Interview: Beta Te...`.

## Determinism

`./tester-env reset && ./tester-env deploy --ref 22723575b04503eb67c9733c63d55179c069903d && ./tester-env seed && ./tester-env verify` passed twice from clean state. Immediate `./tester-env seed && ./tester-env verify` (re-seed without reset) also passed with identical counts.

## Mutation Smoke

- Mutation: `All Links` → `MUTATED Links` in `apps/web/public/locales/en/common.json` line 184.
- Rebuilt, verified via curl in `__NEXT_DATA__` JSON, and browser-checker.
- Source restored to baseline after verification. Baseline deploy confirmed mutation absent.
