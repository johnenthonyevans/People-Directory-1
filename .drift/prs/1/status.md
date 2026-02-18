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
> New CSV parsing and a large bundled dataset now drive list rendering, search, and grouping; malformed/edge-case rows could lead to missing entries or incorrect sections.
> 
> **Overview**
> Adds an in-app people directory backed by a bundled `people.csv`, including a new `Person` model and `PeopleData.load()` CSV parsing to populate the UI.
> 
> Replaces the placeholder `ContentView` with a `NavigationStack` showing a searchable list and a segmented **Group by** control (Name/Level/Location) that sections and sorts results, plus a new `PersonDetailView` for per-person fields (track/level/role/country/audience).
> 
> <sup>Written by [Cursor Bugbot](https://cursor.com/dashboard?tab=bugbot) for commit 4c67316346a4946b5eec8af37fcc868614ea89b1. This will update automatically on new commits. Configure [here](https://cursor.com/dashboard?tab=bugbot).</sup>
<!-- /CURSOR_SUMMARY -->

## Comments

### cursor[bot] — 2026-02-18T17:43:48Z


**People Directory 1/ContentView.swift:45**

### Level sections sort lexicographically instead of numerically

**High Severity**

<!-- DESCRIPTION START -->
The `groupedPeople` property sorts section keys with a plain string comparison (`.sorted { $0.key < $1.key }`). When grouping by level, this produces lexicographic order — placing "L10" and "L11" before "L3" through "L9" — instead of the expected numeric order (L3, L4, …, L9, L10, L11). With the current CSV data containing levels L3–L11, the Level tab displays sections in a confusing, incorrect order.
<!-- DESCRIPTION END -->

<!-- BUGBOT_BUG_ID: 56cd689a-5095-47ab-af94-3d7fd5ebe108 -->

<!-- LOCATIONS START
People Directory 1/ContentView.swift#L42-L45
LOCATIONS END -->
<p><a href="https://cursor.com/open?data=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6ImJ1Z2JvdC12MiJ9.eyJ2ZXJzaW9uIjoxLCJ0eXBlIjoiQlVHQk9UX0ZJWF9JTl9DVVJTT1IiLCJkYXRhIjp7InJlZGlzS2V5IjoiYnVnYm90OmUyNTQyMDBjLWY5MzktNDgzNC1iODVkLWZiM2UyYzE3NGM5MyIsImVuY3J5cHRpb25LZXkiOiJfdmt4ZVRqQWpBMWU0eXI5aE5kTHd3dmx3aWFYc0hLTzlUUjBEeW1pTmxzIiwiYnJhbmNoIjoiZmVhdC9wZW9wbGUtZGlyZWN0b3J5LXVpIiwicmVwb093bmVyIjoiam9obmVudGhvbnlldmFucyIsInJlcG9OYW1lIjoiUGVvcGxlLURpcmVjdG9yeS0xIn0sImlhdCI6MTc3MTQzNjYyOCwiZXhwIjoxNzc0MDI4NjI4fQ.yZR_LrD_2JfIm9EMplQ6pGQ28AB-mVK6-B5GsqkyEji0xojsqSOm46oKBvb_y4lzTF4JqQOjMxWPApIjqrWJv8J7-If9sj0maGKA2N5X5d2Nodp-dJZl5EQxpPlWbbrGKOGAS-GmxwrbHQIiq14ooiav36UmFrxpUr443N4JSCx46xW2NWB7LiKKQpGNgXBk-ykd2i75QG9942_kY1zCVzffStzGiTOGTkf4IwCFK1hGVU-I3f2Sj_vyQYe-XzH2Ca6UE-VhVpycyQ65G27mZYcs9uKFyVN6dzkjs1p1AQ74dmiyGy9AhEujZt5GK4y5DIUKdhXfcwRRuSdgHYN_4g" target="_blank" rel="noopener noreferrer"><picture><source media="(prefers-color-scheme: dark)" srcset="https://cursor.com/assets/images/fix-in-cursor-dark.png"><source media="(prefers-color-scheme: light)" srcset="https://cursor.com/assets/images/fix-in-cursor-light.png"><img alt="Fix in Cursor" width="115" height="28" src="https://cursor.com/assets/images/fix-in-cursor-dark.png"></picture></a>&nbsp;<a href="https://cursor.com/agents?data=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6ImJ1Z2JvdC12MiJ9.eyJ2ZXJzaW9uIjoxLCJ0eXBlIjoiQlVHQk9UX0ZJWF9JTl9XRUIiLCJkYXRhIjp7InJlZGlzS2V5IjoiYnVnYm90OmUyNTQyMDBjLWY5MzktNDgzNC1iODVkLWZiM2UyYzE3NGM5MyIsImVuY3J5cHRpb25LZXkiOiJfdmt4ZVRqQWpBMWU0eXI5aE5kTHd3dmx3aWFYc0hLTzlUUjBEeW1pTmxzIiwiYnJhbmNoIjoiZmVhdC9wZW9wbGUtZGlyZWN0b3J5LXVpIiwicmVwb093bmVyIjoiam9obmVudGhvbnlldmFucyIsInJlcG9OYW1lIjoiUGVvcGxlLURpcmVjdG9yeS0xIiwicHJOdW1iZXIiOjEsImNvbW1pdFNoYSI6IjMyZDJiZTdhYWYzYjU1YTNjNTZlOTU5OTcwMzYwYmQxNWZhZjU2YTgiLCJwcm92aWRlciI6ImdpdGh1YiJ9LCJpYXQiOjE3NzE0MzY2MjgsImV4cCI6MTc3NDAyODYyOH0.IfuzJ6k0ftGZt7mPdR3dx-QITRvKCTW00CJPZy1wOgXe-ZPYUM64-Wy4ed9FnJLK9fkLexx0hwFNEVBD-su77PT0v7QqqBITjm1uKlmzjvcEPphfkrjsCaVjAxeMKNrlwgFvPM53-57_6uTzcXWJ8eE9UyAy-DST1lFqqTiNEStadazB11Edp251wlBtYd9H-TcyHiUaqsYQ1OJVuWfVG8rac-VodFoSNPOmKmqOFG_XJXcgVF4tGG4sBpB_pbCQ1Rr7W2jaxGuwluBZbvmMnyr_icHxJk-BLRxlqc3nAFT1E5U7A6_b6rvUvho3USTFTw9buva3viHC8Y3T4LZrkw" target="_blank" rel="noopener noreferrer"><picture><source media="(prefers-color-scheme: dark)" srcset="https://cursor.com/assets/images/fix-in-web-dark.png"><source media="(prefers-color-scheme: light)" srcset="https://cursor.com/assets/images/fix-in-web-light.png"><img alt="Fix in Web" width="99" height="28" src="https://cursor.com/assets/images/fix-in-web-dark.png"></picture></a></p>

### cursor[bot] — 2026-02-18T17:43:49Z


**People Directory 1/ContentView.swift:100**

### Row subtitle shows dangling separator for empty audience

**Medium Severity**

<!-- DESCRIPTION START -->
In `PersonRowView`, the subtitle is guarded by `!person.role.isEmpty` but unconditionally interpolates `"\(person.role) · \(person.audience)"`. Many people in the CSV have a role but an empty `audience`, producing visible text like "Product Design · " with a trailing dot-separator. The guard needs to also account for whether `audience` is empty, or the interpolation needs to conditionally include the separator.
<!-- DESCRIPTION END -->

<!-- BUGBOT_BUG_ID: ad651cb9-8488-42ff-8e7f-8e448e424894 -->

<!-- LOCATIONS START
People Directory 1/ContentView.swift#L95-L100
LOCATIONS END -->
<p><a href="https://cursor.com/open?data=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6ImJ1Z2JvdC12MiJ9.eyJ2ZXJzaW9uIjoxLCJ0eXBlIjoiQlVHQk9UX0ZJWF9JTl9DVVJTT1IiLCJkYXRhIjp7InJlZGlzS2V5IjoiYnVnYm90OmQxNmEyMjg5LWRmMmItNDE0Ni1hYzA2LTkwYWY2YzBhOTBkZiIsImVuY3J5cHRpb25LZXkiOiJjYThGQ1FzeERjNEl0RlY5NzlMRHJCWEZXR2VSaXNkWDJXWXpobXpMd2ljIiwiYnJhbmNoIjoiZmVhdC9wZW9wbGUtZGlyZWN0b3J5LXVpIiwicmVwb093bmVyIjoiam9obmVudGhvbnlldmFucyIsInJlcG9OYW1lIjoiUGVvcGxlLURpcmVjdG9yeS0xIn0sImlhdCI6MTc3MTQzNjYyOCwiZXhwIjoxNzc0MDI4NjI4fQ.pg7lCjDZ2NSGB_59J2B9PUVwiyv2z5WuLEhEtox7EcJPRiaPptrw5OD3sDIgJxaMye16WWevFkCVx2y04pB-GOopXqK7Amiufn5b2lYPYTwavybS8w7Aleag9eScfXIUf6R7T5Zp12RWrbIsiBiKMBKDoN7JtczDQy01NLwx0JusDzomVa6OvPS4B-mXfxOmkMDU59lqpbgWnnWUMWtKOoH6321YfJrEFZd0e88GOunbIQBWcaU9eyaWcjc_Klf8HIJBsZt8GSLH3PgoV6YnvWKMNVTbbekFJa4JztDlmzN3oQUqsZO8tX1R_RmBy9VwS-4ZUbINsRj1720RKvnENg" target="_blank" rel="noopener noreferrer"><picture><source media="(prefers-color-scheme: dark)" srcset="https://cursor.com/assets/images/fix-in-cursor-dark.png"><source media="(prefers-color-scheme: light)" srcset="https://cursor.com/assets/images/fix-in-cursor-light.png"><img alt="Fix in Cursor" width="115" height="28" src="https://cursor.com/assets/images/fix-in-cursor-dark.png"></picture></a>&nbsp;<a href="https://cursor.com/agents?data=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6ImJ1Z2JvdC12MiJ9.eyJ2ZXJzaW9uIjoxLCJ0eXBlIjoiQlVHQk9UX0ZJWF9JTl9XRUIiLCJkYXRhIjp7InJlZGlzS2V5IjoiYnVnYm90OmQxNmEyMjg5LWRmMmItNDE0Ni1hYzA2LTkwYWY2YzBhOTBkZiIsImVuY3J5cHRpb25LZXkiOiJjYThGQ1FzeERjNEl0RlY5NzlMRHJCWEZXR2VSaXNkWDJXWXpobXpMd2ljIiwiYnJhbmNoIjoiZmVhdC9wZW9wbGUtZGlyZWN0b3J5LXVpIiwicmVwb093bmVyIjoiam9obmVudGhvbnlldmFucyIsInJlcG9OYW1lIjoiUGVvcGxlLURpcmVjdG9yeS0xIiwicHJOdW1iZXIiOjEsImNvbW1pdFNoYSI6IjMyZDJiZTdhYWYzYjU1YTNjNTZlOTU5OTcwMzYwYmQxNWZhZjU2YTgiLCJwcm92aWRlciI6ImdpdGh1YiJ9LCJpYXQiOjE3NzE0MzY2MjgsImV4cCI6MTc3NDAyODYyOH0.pfCjqZLjz9wCCZmwOLIqYXmR-eIYWVUmdl-QP2DSasdElqwtZUNdzK24qbDUpx4-e5z7tByETGeAGBvRqH8RspirU9yKA2_eqYQicfrDBLGV6bVAjOYmKHY8e6B8j_Oh8AnOdKVMmAoMXJhrN_gQFhhSS4i2Mdm-ooDznRhF7jcQsNLnkGAY3Bsnsd11XkGFuj0mwnH6XrAiq91tCytNPhZAzt36maktsGr_0OxF_ZIP20mv5GPChO2vXL0ZcwAtLMnmohLizqInIqyvH_AMPPeiVEB_odk8HoPXmUgZTOwprLFzOWBXrs51s07DLak5WgmOK06w8DH51fxCmZFguw" target="_blank" rel="noopener noreferrer"><picture><source media="(prefers-color-scheme: dark)" srcset="https://cursor.com/assets/images/fix-in-web-dark.png"><source media="(prefers-color-scheme: light)" srcset="https://cursor.com/assets/images/fix-in-web-light.png"><img alt="Fix in Web" width="99" height="28" src="https://cursor.com/assets/images/fix-in-web-dark.png"></picture></a></p>

### johnenthonyevans — 2026-02-18T17:33:36Z


Hey I think that it be great to add tabs so I can see the data grouped by level, location, or name. 

### johnenthonyevans — 2026-02-18T17:37:10Z


🧟‍♀️ Drift: Added segmented picker with Name/Level/Location tabs. People list is now grouped into sections by first letter of name, level (L5-L10), or country. Each section is sorted alphabetically.

### johnenthonyevans — 2026-02-18T17:38:25Z


### 🧟‍♀️ Drift: Capture

https://github.com/johnenthonyevans/People-Directory-1/raw/screenshots/captures/pr-1/2026-02-18T17-38-18Z/capture.mp4

<img src="https://github.com/johnenthonyevans/People-Directory-1/raw/screenshots/captures/pr-1/2026-02-18T17-38-18Z/interactions/interaction-1-00m02s000.png" width="300" />

<img src="https://github.com/johnenthonyevans/People-Directory-1/raw/screenshots/captures/pr-1/2026-02-18T17-38-18Z/interactions/interaction-2-00m03s000.png" width="300" />

<img src="https://github.com/johnenthonyevans/People-Directory-1/raw/screenshots/captures/pr-1/2026-02-18T17-38-18Z/interactions/interaction-3-00m05s000.png" width="300" />

<img src="https://github.com/johnenthonyevans/People-Directory-1/raw/screenshots/captures/pr-1/2026-02-18T17-38-18Z/interactions/interaction-4-00m06s000.png" width="300" />

<img src="https://github.com/johnenthonyevans/People-Directory-1/raw/screenshots/captures/pr-1/2026-02-18T17-38-18Z/interactions/interaction-5-00m07s000.png" width="300" />

<img src="https://github.com/johnenthonyevans/People-Directory-1/raw/screenshots/captures/pr-1/2026-02-18T17-38-18Z/interactions/interaction-6-00m07s000.png" width="300" />

**Transcript:**
> Cool I added the tabs I
kind of agreed they look pretty good so let's stick with the tabs

_Captured 2026-02-18T17:38:18Z (9s, interaction, window: Simulator — iPhone 17)_

### matej-doordash — 2026-02-18T18:08:23Z


I think the profile picture needs in the profile view needs a bit of a breathing room

### johnenthonyevans — 2026-02-18T18:27:20Z


🧟‍♀️ Drift: Added vertical padding to the profile avatar header in the detail view per @matej-doordash's feedback — gives the initials circle more breathing room.

### johnenthonyevans — 2026-02-18T18:29:28Z


### 🧟‍♀️ Drift: Capture

https://github.com/johnenthonyevans/People-Directory-1/raw/screenshots/captures/pr-1/2026-02-18T18-29-23Z/capture.mp4

<img src="https://github.com/johnenthonyevans/People-Directory-1/raw/screenshots/captures/pr-1/2026-02-18T18-29-23Z/snap-1.png" width="300" />

**Transcript:**
> I'm just gonna do this thing and cut the subtitles
and say hi

**Notes:**
> Hey @matej-doordash this is the right thing to do. Approved to ship now?

_Captured 2026-02-18T18:29:23Z (7s, interaction, window: Simulator — iPhone 17)_

## Tasks

- [ ] (Review PR and add tasks)
