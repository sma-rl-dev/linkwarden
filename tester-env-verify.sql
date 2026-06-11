DO $$
DECLARE
  failures text[] := ARRAY[]::text[];
  value int;
BEGIN
  SELECT COUNT(*) INTO value FROM "User" WHERE id = 1 AND username = 'tester' AND name = 'Taylor QA' AND password IS NOT NULL;
  IF value <> 1 THEN failures := failures || 'tester user missing'; END IF;

  SELECT COUNT(*) INTO value FROM "Collection" WHERE "ownerId" = 1;
  IF value <> 5 THEN failures := failures || format('expected 5 collections, got %s', value); END IF;

  SELECT COUNT(*) INTO value FROM "Collection" WHERE "parentId" IS NOT NULL;
  IF value <> 2 THEN failures := failures || format('expected 2 nested collections, got %s', value); END IF;

  SELECT COUNT(*) INTO value FROM "Collection" child JOIN "Collection" parent ON parent.id = child."parentId" WHERE child.name = 'Design System' AND parent.name = 'Product Research';
  IF value <> 1 THEN failures := failures || 'Design System is not nested under Product Research'; END IF;

  SELECT COUNT(*) INTO value FROM "Collection" child JOIN "Collection" parent ON parent.id = child."parentId" WHERE child.name = 'Release Planning' AND parent.name = 'Engineering Notes';
  IF value <> 1 THEN failures := failures || 'Release Planning is not nested under Engineering Notes'; END IF;

  SELECT COUNT(*) INTO value FROM "Link" WHERE "createdById" = 1;
  IF value <> 12 THEN failures := failures || format('expected 12 links, got %s', value); END IF;

  SELECT COUNT(*) INTO value FROM "Tag" WHERE "ownerId" = 1;
  IF value <> 9 THEN failures := failures || format('expected 9 tags, got %s', value); END IF;

  SELECT COUNT(*) INTO value FROM "_PinnedLinks" WHERE "B" = 1;
  IF value <> 3 THEN failures := failures || format('expected 3 pinned links, got %s', value); END IF;

  SELECT COUNT(*) INTO value FROM "_LinkToTag";
  IF value <> 27 THEN failures := failures || format('expected 27 link/tag joins, got %s', value); END IF;

  SELECT COUNT(*) INTO value FROM "DashboardSection" WHERE "userId" = 1;
  IF value <> 5 THEN failures := failures || format('expected 5 dashboard sections, got %s', value); END IF;

  SELECT COUNT(*) INTO value FROM "Link" WHERE name IN ('Northstar Q1 Roadmap Brief', 'Atlas Changelog: Saved Views', 'Component Library: Filter Chips') AND id IN (1,5,9);
  IF value <> 3 THEN failures := failures || 'expected stable pinned link names are missing'; END IF;

  SELECT COUNT(*) INTO value FROM "Link" WHERE description ILIKE '%vector-retrospective%';
  IF value <> 1 THEN failures := failures || 'search phrase vector-retrospective missing'; END IF;

  SELECT COUNT(*) INTO value FROM "Link" WHERE "indexVersion" IS DISTINCT FROM 1;
  IF value <> 0 THEN failures := failures || format('expected 0 pending search-index links, got %s', value); END IF;

  IF array_length(failures, 1) IS NOT NULL THEN
    RAISE EXCEPTION 'Seed verification failed: %', array_to_string(failures, '; ');
  END IF;
END $$;

SELECT
  (SELECT COUNT(*) FROM "Collection") AS collections,
  (SELECT COUNT(*) FROM "Link") AS links,
  (SELECT COUNT(*) FROM "Tag") AS tags,
  (SELECT COUNT(*) FROM "_PinnedLinks") AS pinned_links,
  (SELECT COUNT(*) FROM "Collection" WHERE "parentId" IS NOT NULL) AS nested_collections;
