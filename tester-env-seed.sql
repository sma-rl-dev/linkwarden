BEGIN;

TRUNCATE TABLE "User" RESTART IDENTITY CASCADE;

INSERT INTO "User" (
  id, name, username, email, password, locale, theme,
  "collectionOrder", "createdAt", "updatedAt",
  "archiveAsScreenshot", "archiveAsMonolith", "archiveAsPDF", "archiveAsReadable",
  "archiveAsWaybackMachine", "linksRouteTo", "aiTaggingMethod",
  "aiPredefinedTags", "aiTagExistingLinks", "preventDuplicateLinks",
  "acceptPromotionalEmails", "trialEndEmailSent", "isPrivate"
) VALUES (
  1, 'Taylor QA', 'tester', 'taylor.qa@northstar.example', '$2b$10$FkFNvik3RJ53.ZiJKWE/3uH/Z.7BEu10sVEWXX0bxbWLMw1Dv6wDy', 'en', 'dark',
  ARRAY[1,4,2,3,5], '2026-01-05 09:00:00', '2026-01-05 09:00:00',
  true, true, true, true,
  false, 'ORIGINAL', 'DISABLED',
  ARRAY[]::text[], false, false,
  false, false, false
);

INSERT INTO "Collection" (id, name, description, color, "isPublic", "ownerId", "createdById", "parentId", icon, "iconWeight", "createdAt", "updatedAt") VALUES
  (1, 'Product Research', 'Customer interviews, usability studies, and validation evidence for Northstar Product Lab.', '#2563eb', false, 1, 1, NULL, 'flask-conical', 'regular', '2026-01-06 10:00:00', '2026-01-06 10:00:00'),
  (2, 'Market Intel', 'Competitive analysis, pricing pages, and public benchmark reports.', '#7c3aed', false, 1, 1, NULL, 'telescope', 'regular', '2026-01-07 10:00:00', '2026-01-07 10:00:00'),
  (3, 'Engineering Notes', 'Architecture references, API guidelines, and reliability checklists.', '#059669', false, 1, 1, NULL, 'code', 'regular', '2026-01-08 10:00:00', '2026-01-08 10:00:00'),
  (4, 'Design System', 'Nested product research collection for UI patterns and accessibility references.', '#db2777', false, 1, 1, 1, 'palette', 'regular', '2026-01-09 10:00:00', '2026-01-09 10:00:00'),
  (5, 'Release Planning', 'Nested engineering collection for launch readiness and rollout coordination.', '#ea580c', false, 1, 1, 3, 'rocket', 'regular', '2026-01-10 10:00:00', '2026-01-10 10:00:00');

INSERT INTO "Tag" (id, name, "ownerId", "createdAt", "updatedAt", "archiveAsScreenshot", "archiveAsMonolith", "archiveAsPDF", "archiveAsReadable", "archiveAsWaybackMachine", "aiTag", "aiGenerated") VALUES
  (1, 'roadmap', 1, '2026-01-06 12:00:00', '2026-01-06 12:00:00', true, true, true, true, false, false, false),
  (2, 'research', 1, '2026-01-06 12:05:00', '2026-01-06 12:05:00', true, true, true, true, false, false, false),
  (3, 'competitor', 1, '2026-01-07 12:00:00', '2026-01-07 12:00:00', true, true, true, true, false, false, false),
  (4, 'design', 1, '2026-01-09 12:00:00', '2026-01-09 12:00:00', true, true, true, true, false, false, false),
  (5, 'api', 1, '2026-01-08 12:00:00', '2026-01-08 12:00:00', true, true, true, true, false, false, false),
  (6, 'launch', 1, '2026-01-10 12:00:00', '2026-01-10 12:00:00', true, true, true, true, false, false, false),
  (7, 'security', 1, '2026-01-11 12:00:00', '2026-01-11 12:00:00', true, true, true, true, false, false, false),
  (8, 'ux', 1, '2026-01-12 12:00:00', '2026-01-12 12:00:00', true, true, true, true, false, false, false),
  (9, 'metrics', 1, '2026-01-13 12:00:00', '2026-01-13 12:00:00', true, true, true, true, false, false, false);

INSERT INTO "Link" (
  id, name, url, description, "collectionId", "createdById", type,
  "createdAt", "updatedAt", "lastPreserved", image, pdf, readable, monolith, preview,
  "textContent", "indexVersion", "clientSide", "aiTagged", "metaDescription"
) VALUES
  (1, 'Northstar Q1 Roadmap Brief', 'https://example.com/northstar/q1-roadmap', 'Prioritized outcomes for activation, retention, and the Atlas onboarding milestone.', 1, 1, 'url', '2026-01-15 09:15:00', '2026-01-15 09:15:00', '2026-01-15 09:16:00', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'Atlas onboarding roadmap activation retention', NULL, false, false, 'Roadmap brief for Northstar Product Lab'),
  (2, 'Customer Interview: Beta Team', 'https://example.org/research/beta-team-interview', 'Interview notes highlighting import friction, saved-view requests, and vector-retrospective evidence.', 1, 1, 'url', '2026-01-18 14:30:00', '2026-01-18 14:30:00', '2026-01-18 14:31:00', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'Beta Team import friction saved views vector-retrospective', NULL, false, false, 'Customer interview notes'),
  (3, 'Jobs To Be Done Survey Results', 'https://example.net/reports/jtbd-survey-2026', 'Quantitative research report with 42 buyer responses and onboarding success metrics.', 1, 1, 'url', '2026-01-22 11:00:00', '2026-01-22 11:00:00', '2026-01-22 11:01:00', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'JTBD survey buyer responses onboarding metrics', NULL, false, false, 'Survey result report'),
  (4, 'Waypoint Pricing Page Snapshot', 'https://waypoint.example.com/pricing', 'Competitor pricing snapshot for seat limits, SSO packaging, and enterprise trial language.', 2, 1, 'url', '2026-02-02 10:05:00', '2026-02-02 10:05:00', '2026-02-02 10:06:00', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'Waypoint pricing SSO enterprise trial competitor', NULL, false, false, 'Competitor pricing page'),
  (5, 'Atlas Changelog: Saved Views', 'https://atlas.example.com/changelog/saved-views', 'Competing launch announcement for saved filters, collection sharing, and dashboard pins.', 2, 1, 'url', '2026-02-05 16:20:00', '2026-02-05 16:20:00', '2026-02-05 16:21:00', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'Atlas saved views filters dashboard pins competitor', NULL, false, false, 'Competitor changelog'),
  (6, '2026 SaaS Collaboration Benchmarks', 'https://example.edu/benchmarks/saas-collaboration-2026', 'Industry benchmark report for collaboration latency, admin adoption, and workspace growth.', 2, 1, 'url', '2026-02-11 08:45:00', '2026-02-11 08:45:00', '2026-02-11 08:46:00', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'collaboration latency admin adoption workspace growth metrics', NULL, false, false, 'SaaS collaboration benchmarks'),
  (7, 'Public API Pagination Pattern', 'https://docs.example.com/api/pagination-pattern', 'Reference pattern for cursor pagination, stable sorting, and API response metadata.', 3, 1, 'url', '2026-02-16 13:10:00', '2026-02-16 13:10:00', '2026-02-16 13:11:00', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'API cursor pagination sorting metadata', NULL, false, false, 'API pagination reference'),
  (8, 'Security Review Checklist', 'https://security.example.com/checklists/product-launch', 'Launch security checklist covering SSO, audit logs, rate limits, and token rotation.', 3, 1, 'url', '2026-02-20 09:40:00', '2026-02-20 09:40:00', '2026-02-20 09:41:00', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'security SSO audit logs rate limits token rotation launch', NULL, false, false, 'Security checklist'),
  (9, 'Component Library: Filter Chips', 'https://design.example.com/components/filter-chips', 'Design guidance for removable filter chips, empty states, and keyboard focus rings.', 4, 1, 'url', '2026-03-01 15:00:00', '2026-03-01 15:00:00', '2026-03-01 15:01:00', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'filter chips empty states keyboard focus UX design', NULL, false, false, 'Design system component guidance'),
  (10, 'Accessibility Audit Notes', 'https://design.example.com/a11y/audit-notes', 'Accessibility notes for modal labels, contrast fixes, and collection tree navigation.', 4, 1, 'url', '2026-03-04 10:30:00', '2026-03-04 10:30:00', '2026-03-04 10:31:00', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'accessibility modal labels contrast collection tree navigation', NULL, false, false, 'Accessibility audit notes'),
  (11, 'March Launch Readiness Checklist', 'https://example.com/releases/march-readiness', 'Release readiness checklist for docs freeze, metrics dashboard, and staged rollout owners.', 5, 1, 'url', '2026-03-10 12:00:00', '2026-03-10 12:00:00', '2026-03-10 12:01:00', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'launch readiness docs freeze metrics dashboard staged rollout', NULL, false, false, 'Launch readiness checklist'),
  (12, 'Post Launch Metrics Review', 'https://example.com/releases/post-launch-metrics', 'Metrics review template for activation lift, search success, support tickets, and retention deltas.', 5, 1, 'url', '2026-03-18 17:25:00', '2026-03-18 17:25:00', '2026-03-18 17:26:00', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'unavailable', 'activation lift search success support tickets retention deltas metrics', NULL, false, false, 'Post launch metrics review');

INSERT INTO "_LinkToTag" ("A", "B") VALUES
  (1,1),(1,2),(1,9),
  (2,2),(2,8),
  (3,2),(3,9),
  (4,3),(4,9),
  (5,3),(5,1),(5,6),
  (6,3),(6,9),
  (7,5),(7,7),
  (8,7),(8,6),
  (9,4),(9,8),
  (10,4),(10,8),
  (11,6),(11,1),(11,9),
  (12,6),(12,9);

INSERT INTO "_PinnedLinks" ("A", "B") VALUES
  (1,1), (5,1), (9,1);

INSERT INTO "DashboardSection" (id, "userId", "collectionId", type, "order", "createdAt", "updatedAt") VALUES
  (1, 1, NULL, 'STATS', 0, '2026-01-05 09:00:00', '2026-01-05 09:00:00'),
  (2, 1, NULL, 'RECENT_LINKS', 1, '2026-01-05 09:00:00', '2026-01-05 09:00:00'),
  (3, 1, NULL, 'PINNED_LINKS', 2, '2026-01-05 09:00:00', '2026-01-05 09:00:00'),
  (4, 1, 1, 'COLLECTION', 3, '2026-01-06 10:00:00', '2026-01-06 10:00:00'),
  (5, 1, 3, 'COLLECTION', 4, '2026-01-08 10:00:00', '2026-01-08 10:00:00');

SELECT setval('"User_id_seq"', (SELECT MAX(id) FROM "User"));
SELECT setval('"Collection_id_seq"', (SELECT MAX(id) FROM "Collection"));
SELECT setval('"Tag_id_seq"', (SELECT MAX(id) FROM "Tag"));
SELECT setval('"Link_id_seq"', (SELECT MAX(id) FROM "Link"));
SELECT setval('"DashboardSection_id_seq"', (SELECT MAX(id) FROM "DashboardSection"));

COMMIT;
