# Execution Prompt: Add people directory with search and detail views

## Task

You are implementing PR #1 on johnenthonyevans/People-Directory-1. Branch: `feat/people-directory-ui`. State: action.

## Pending Directives (implement ALL)

### 1. @johnenthonyevans (PR author) — 2026-02-18T17:33:36Z


Hey I think that it be great to add tabs so I can see the data grouped by level, location, or name. 


## Feedback (consider while implementing)

### @matej-doordash — 2026-02-18T18:08:23Z


I think the profile picture needs in the profile view needs a bit of a breathing room


## PR Description

Hey I think this is a bit basic, but does the job, what should I add?

Add a people directory that loads from CSV, displays a searchable list with initials avatars, and navigates to a detail view with level, role, country, and audience.

[Watch a detailed screen recording](.drift/prs/1/assets/asset-8.mp4)

<img src=".drift/prs/1/assets/asset-9.png" width="300" />
> [8s] The People list view showing each person with their initials, role, and audience.

<img src=".drift/prs/1/assets/asset-10.png" width="300" />
> [17s] Scrolling through the full list — it shows everyone loaded from the CSV.

<img src=".drift/prs/1/assets/asset-11.png" width="300" />
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

## Instructions

1. If directives reference images, read the image files for visual context before implementing.
2. Implement ALL pending directives above.
3. Consider feedback where relevant.
4. When done, run:
   ```
   /Users/john/Code/Drift/agent/drift-agent update --repo johnenthonyevans/People-Directory-1 --pr 1 --repo-dir . --message "summary of what you implemented"
   ```

## Guard Rails

- Do NOT merge the PR.
- Do NOT create new branches.
- Do NOT modify the .drift/ directory.
- Do NOT run drift-agent commands other than `update`.
- Focus on implementing the plan, then call update. That's it.
