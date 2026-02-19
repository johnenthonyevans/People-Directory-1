# Execution Prompt: Empty PR

## Task

You are implementing PR #2 on johnenthonyevans/People-Directory-1. Branch: `empty-pr`. State: action.

## Pending Directives (implement ALL)

### 1. @johnenthonyevans (PR author) — 2026-02-18T21:05:49Z


Plan — priorities and tradeoffs

Must (high impact, low-to-medium effort)

Clean card-based list (avatar, name, level badge, location) — replace plain rows.

Search + filters (by location, level).

Tappable card → animated detail sheet using matchedGeometryEffect.

Async avatars + initials fallback.

Accessible labels and dynamic type support.

Should (medium impact, medium effort)

Map view that clusters people by location and links back to the list.

Presence / status indicator (office / remote / PTO) + heatmap of density.

Context menu on a person row (copy email, message, call).

Sorting and grouping (by team, office, level).

Nice-to-have (lower priority, higher effort)

Profile completion micro-goals (encourage avatar + title).

Inline org chart / manager links.

Tiny onboarding animation & “people you should know” card powered by simple heuristics.

Analytics (popular profiles, search queries) and A/B testing for microcopy.

Trade-offs

Heavy animations and map clustering add complexity and battery/CPU hit; prefer GPU-friendly SwiftUI animations and server-side cluster data if scale is large.

Including many real-time features (presence) requires backend support — start with manual status or infrequent polling.

Map + List sync increases code surface; implement as separate modules first.

UX & Visual system (rules of thumb)

Use a single accent color per org; support light/dark automatically.

Card height ~ 72–96pt with 40–56px avatars for fast scanning.

Use a compact badge for “level” (e.g., L3) — consistent shape (rounded capsule) and color by band.

Motion: subtle scale + shadow on press, smooth detail transition (matched geometry).

Microcopy: show contact method first (email/Slack), then role/level, then location.

Accessibility: VoiceOver labels like “Ava Chen, Senior Product Designer, Level L4, San Francisco office.”


## Feedback (consider while implementing)

### @cursor[bot] — 2026-02-18T21:37:43Z


**People Directory 1/ContentView.swift:106**

### Matched geometry source not hidden during transition

**Medium Severity**

<!-- DESCRIPTION START -->
`PersonCardView` and `PersonDetailSheet` both register the same `matchedGeometryEffect` IDs (`"avatar-"`, `"name-"`, `"level-"`) with the default `isSource: true`, and both remain in the view hierarchy simultaneously when a person is selected. The card in the `ScrollView` is never hidden or faded when the detail overlay appears. This causes undefined animation behavior — the hero transition that morphs the card into the detail sheet won't work correctly, likely producing visual jumps or duplicate elements instead of a smooth morph.
<!-- DESCRIPTION END -->

<!-- BUGBOT_BUG_ID: 2c481bed-6953-4765-a597-eb6af9368e24 -->

<!-- LOCATIONS START
People Directory 1/ContentView.swift#L100-L106
People Directory 1/ContentView.swift#L125-L132
LOCATIONS END -->
<details>
<summary>Additional Locations (1)</summary>

- [`People Directory 1/ContentView.swift#L125-L132`](https://github.com/johnenthonyevans/People-Directory-1/blob/035bf571d82da4bad36fd1eb1ceb7a35d641d5a5/People Directory 1/ContentView.swift#L125-L132)

</details>

<p><a href="https://cursor.com/open?data=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6ImJ1Z2JvdC12MiJ9.eyJ2ZXJzaW9uIjoxLCJ0eXBlIjoiQlVHQk9UX0ZJWF9JTl9DVVJTT1IiLCJkYXRhIjp7InJlZGlzS2V5IjoiYnVnYm90OmIzNzNjODkyLTc4MWMtNGU1YS1iMTU5LTM0YmFhZDExMjZjNCIsImVuY3J5cHRpb25LZXkiOiJyeTl2UHJQUmh5WFhIX01qaVJIWEp4MTBsVXdRb3kwQ3V6ZW5SR0dWU0pZIiwiYnJhbmNoIjoiZW1wdHktcHIiLCJyZXBvT3duZXIiOiJqb2huZW50aG9ueWV2YW5zIiwicmVwb05hbWUiOiJQZW9wbGUtRGlyZWN0b3J5LTEifSwiaWF0IjoxNzcxNDUwNjYzLCJleHAiOjE3NzQwNDI2NjN9.06e4n_-uGtKnQyhU9uO04Eb5qceqRm-BLBGkEKqeGcbHo_c398dVjq93ztFs3PxmtoLc7eXf55Q68fEbIogvpM3_yg1YZzQPiE9biba_Qk3-pU7YyGuoT8DgNXU19ekNappx6phH_XWm-egxKoQSyGXluxWLYIpcAUD1K5GCxnQOdMKWVmZ_aYOIPv3Fpq-GsTN0UjEnjRDs0_BWQZCOIgtDFJiuW7L4JnrZDJSSc03I5ZXhDTpZmQjQrkYrcMS-pkYUcVBBaLqHHIRlgzqDeMiWnzM44Z0bAy1Pza-H7g7CIKKSmeqzIbf5FBLOyDXWJ5YBn5BIhTt3SIUnd6hfHQ" target="_blank" rel="noopener noreferrer"><picture><source media="(prefers-color-scheme: dark)" srcset=".drift/prs/2/assets/asset-1.png"><source media="(prefers-color-scheme: light)" srcset=".drift/prs/2/assets/asset-2.png"><img alt="Fix in Cursor" width="115" height="28" src=".drift/prs/2/assets/asset-1.png"></picture></a>&nbsp;<a href="https://cursor.com/agents?data=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6ImJ1Z2JvdC12MiJ9.eyJ2ZXJzaW9uIjoxLCJ0eXBlIjoiQlVHQk9UX0ZJWF9JTl9XRUIiLCJkYXRhIjp7InJlZGlzS2V5IjoiYnVnYm90OmIzNzNjODkyLTc4MWMtNGU1YS1iMTU5LTM0YmFhZDExMjZjNCIsImVuY3J5cHRpb25LZXkiOiJyeTl2UHJQUmh5WFhIX01qaVJIWEp4MTBsVXdRb3kwQ3V6ZW5SR0dWU0pZIiwiYnJhbmNoIjoiZW1wdHktcHIiLCJyZXBvT3duZXIiOiJqb2huZW50aG9ueWV2YW5zIiwicmVwb05hbWUiOiJQZW9wbGUtRGlyZWN0b3J5LTEiLCJwck51bWJlciI6MiwiY29tbWl0U2hhIjoiMDM1YmY1NzFkODJkYTRiYWQzNmZkMWViMWNlYjdhMzVkNjQxZDVhNSIsInByb3ZpZGVyIjoiZ2l0aHViIn0sImlhdCI6MTc3MTQ1MDY2MywiZXhwIjoxNzc0MDQyNjYzfQ.TyZI5YXql_JTLkZJJ49uc7o9O8ceNs1Nm3udiAxUzP1ovi4dLR8MItaA8W0DhBp6F4oq_FV7cB_47Qo0kLIHoXJEy-owe829ZSlUejq9r7a6OWJTppm5LVoS25wjxF5NvSCH0jaX5vwmXRb4U9op-Y_fVXFDttb4hF042IsXS5gyV1ILzuxENEt8W8VxIm3sDdHneNXVFXjPY7t72FO4I15zxAy-N-3y8i4_y8ciNVOYR456BBWJB3ZdEQAyIHw0GYNHu_YXjE0ZngsUHvj2rNLaOC5VUUYUTWlVOqNaZOXUjwLuFA33f0jFCmw0UJsoyE39S36YY24KfZoz0P1RAw" target="_blank" rel="noopener noreferrer"><picture><source media="(prefers-color-scheme: dark)" srcset=".drift/prs/2/assets/asset-3.png"><source media="(prefers-color-scheme: light)" srcset=".drift/prs/2/assets/asset-4.png"><img alt="Fix in Web" width="99" height="28" src=".drift/prs/2/assets/asset-3.png"></picture></a></p>


## PR Description

<!-- CURSOR_SUMMARY -->
> [!NOTE]
> **Medium Risk**
> Introduces a custom CSV parser and a large bundled dataset that drives UI grouping/sorting; malformed rows or unexpected values could cause missing or misordered entries.
> 
> **Overview**
> Adds an in-app **People directory** driven by a bundled `people.csv`, including a new `Person` model and `PeopleData` CSV loader.
> 
> Replaces the placeholder `ContentView` with a searchable, filterable UI that can *group by* Name/Level/Location, shows card-style rows with level badges and async avatars, and opens a matched-geometry detail sheet with improved spacing plus copy actions via a context menu.
> 
> Includes data/UX fixes: numeric ordering for Level sections, case-insensitive name sorting, no dangling role/audience separator, and correct initials for contractor-suffixed names like `[C]`.
> 
> <sup>Written by [Cursor Bugbot](https://cursor.com/dashboard?tab=bugbot) for commit 035bf571d82da4bad36fd1eb1ceb7a35d641d5a5. This will update automatically on new commits. Configure [here](https://cursor.com/dashboard?tab=bugbot).</sup>
<!-- /CURSOR_SUMMARY -->

## Instructions

1. If directives reference images, read the image files for visual context before implementing.
2. Implement ALL pending directives above.
3. Consider feedback where relevant.
4. When done, run:
   ```
   /Users/john/Code/Drift/agent/drift-agent update --repo johnenthonyevans/People-Directory-1 --pr 2 --repo-dir . --message "summary of what you implemented"
   ```

## Guard Rails

- Do NOT merge the PR.
- Do NOT create new branches.
- Do NOT modify the .drift/ directory.
- Do NOT run drift-agent commands other than `update`.
- Focus on implementing the plan, then call update. That's it.
