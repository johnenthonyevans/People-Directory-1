# Status: Add people directory with search and detail views

Branch: `feat/people-directory-ui` → `main` | State: open

## TL;DR

🔧 ACTION NEEDED — pending directives to implement.

---

## PR Description

Hey I think this is a bit basic, but does the job, what should I add?

Add a people directory that loads from CSV, displays a searchable list with initials avatars, and navigates to a detail view with level, role, country, and audience.

[Watch a detailed screen recording](https://github.com/johnenthonyevans/People-Directory-1/raw/screenshots/captures/pre-pr/feat-people-directory-ui/2026-02-18T17-30-49Z/capture.mp4)

<img src="https://github.com/johnenthonyevans/People-Directory-1/raw/screenshots/captures/pre-pr/feat-people-directory-ui/2026-02-18T17-30-49Z/interactions/interaction-1-00m08s000.png" width="300" />
> [8s] The People list view showing each person with their initials, role, and audience.

<img src="https://github.com/johnenthonyevans/People-Directory-1/raw/screenshots/captures/pre-pr/feat-people-directory-ui/2026-02-18T17-30-49Z/interactions/interaction-7-00m17s000.png" width="300" />
> [17s] Scrolling through the full list — it shows everyone loaded from the CSV.

<img src="https://github.com/johnenthonyevans/People-Directory-1/raw/screenshots/captures/pre-pr/feat-people-directory-ui/2026-02-18T17-30-49Z/interactions/interaction-9-00m29s000.png" width="300" />
> [29s] Tapping into a person shows the detail view with level, role, country, and audience.

1. `Person.swift` — new model struct with `fullName`, `track`, `level`, `role`, `country`, `audience`, and computed `initials`
2. `PeopleData.swift` — CSV parser that loads `people.csv` from the app bundle
3. `ContentView.swift` — replaced placeholder with `NavigationStack`, searchable `List`, `PersonRowView` (initials avatar + name/role), and `PersonDetailView` (level, role, country, audience)
4. `people.csv` — directory data with ~40 people

_Created with Drift capture_

<!-- CURSOR_SUMMARY -->
---

> [!NOTE]
> **Medium Risk**
> New CSV parsing plus a large bundled dataset now drives navigation and grouping; malformed/edge-case CSV rows could lead to missing entries, incorrect sections, or empty lists.
> 
> **Overview**
> Adds an in-app people directory backed by a bundled `people.csv`, including a new `Person` model and `PeopleData.load()` CSV parsing to populate the UI.
> 
> Replaces the placeholder `ContentView` with a `NavigationStack` that shows a searchable list of people, supports **segmented “Group by” tabs** (name/level/location) to section the list, and navigates to a `PersonDetailView` showing per-person attributes (track/level/role/country/audience).
> 
> <sup>Written by [Cursor Bugbot](https://cursor.com/dashboard?tab=bugbot) for commit 32d2be7aaf3b55a3c56e959970360bd15faf56a8. This will update automatically on new commits. Configure [here](https://cursor.com/dashboard?tab=bugbot).</sup>
<!-- /CURSOR_SUMMARY -->

## Comments

### johnenthonyevans — 2026-02-18T17:33:36Z


Hey I think that it be great to add tabs so I can see the data grouped by level, location, or name. 

### johnenthonyevans — 2026-02-18T17:37:10Z


🧟‍♀️ Drift: Added segmented picker with Name/Level/Location tabs. People list is now grouped into sections by first letter of name, level (L5-L10), or country. Each section is sorted alphabetically.

### johnenthonyevans — 2026-02-18T17:38:25Z


### 🧟‍♀️ Drift: Capture

https://github.com/johnenthonyevans/People-Directory-1/raw/screenshots/captures/pr-1/2026-02-18T17-38-18Z/capture.mp4

![interaction-1-00m02s000.png](https://github.com/johnenthonyevans/People-Directory-1/raw/screenshots/captures/pr-1/2026-02-18T17-38-18Z/interactions/interaction-1-00m02s000.png)

![interaction-2-00m03s000.png](https://github.com/johnenthonyevans/People-Directory-1/raw/screenshots/captures/pr-1/2026-02-18T17-38-18Z/interactions/interaction-2-00m03s000.png)

![interaction-3-00m05s000.png](https://github.com/johnenthonyevans/People-Directory-1/raw/screenshots/captures/pr-1/2026-02-18T17-38-18Z/interactions/interaction-3-00m05s000.png)

![interaction-4-00m06s000.png](https://github.com/johnenthonyevans/People-Directory-1/raw/screenshots/captures/pr-1/2026-02-18T17-38-18Z/interactions/interaction-4-00m06s000.png)

![interaction-5-00m07s000.png](https://github.com/johnenthonyevans/People-Directory-1/raw/screenshots/captures/pr-1/2026-02-18T17-38-18Z/interactions/interaction-5-00m07s000.png)

![interaction-6-00m07s000.png](https://github.com/johnenthonyevans/People-Directory-1/raw/screenshots/captures/pr-1/2026-02-18T17-38-18Z/interactions/interaction-6-00m07s000.png)

**Transcript:**
> Cool I added the tabs I
kind of agreed they look pretty good so let's stick with the tabs

_Captured 2026-02-18T17:38:18Z (9s, interaction, window: Simulator — iPhone 17)_

### matej-doordash — 2026-02-18T18:08:23Z


I think the profile picture needs in the profile view needs a bit of a breathing room

## Tasks

- [ ] (Review PR and add tasks)
