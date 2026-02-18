# Execution Prompt: Add people directory with search and detail views

## Task

You are implementing PR #1 on johnenthonyevans/People-Directory-1. Branch: `feat/people-directory-ui`. State: action.

## Pending Directives (implement ALL)

### 1. @johnenthonyevans (PR author) — 2026-02-18T17:33:36Z


Hey I think that it be great to add tabs so I can see the data grouped by level, location, or name. 


## Feedback (consider while implementing)

### @cursor[bot] — 2026-02-18T17:43:48Z


**People Directory 1/ContentView.swift**

### Level sections sort lexicographically instead of numerically

**High Severity**

<!-- DESCRIPTION START -->
The `groupedPeople` property sorts section keys with a plain string comparison (`.sorted { $0.key < $1.key }`). When grouping by level, this produces lexicographic order — placing "L10" and "L11" before "L3" through "L9" — instead of the expected numeric order (L3, L4, …, L9, L10, L11). With the current CSV data containing levels L3–L11, the Level tab displays sections in a confusing, incorrect order.
<!-- DESCRIPTION END -->

<!-- BUGBOT_BUG_ID: 56cd689a-5095-47ab-af94-3d7fd5ebe108 -->

<!-- LOCATIONS START
People Directory 1/ContentView.swift#L42-L45
LOCATIONS END -->
<p><a href="https://cursor.com/open?data=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6ImJ1Z2JvdC12MiJ9.eyJ2ZXJzaW9uIjoxLCJ0eXBlIjoiQlVHQk9UX0ZJWF9JTl9DVVJTT1IiLCJkYXRhIjp7InJlZGlzS2V5IjoiYnVnYm90OmUyNTQyMDBjLWY5MzktNDgzNC1iODVkLWZiM2UyYzE3NGM5MyIsImVuY3J5cHRpb25LZXkiOiJfdmt4ZVRqQWpBMWU0eXI5aE5kTHd3dmx3aWFYc0hLTzlUUjBEeW1pTmxzIiwiYnJhbmNoIjoiZmVhdC9wZW9wbGUtZGlyZWN0b3J5LXVpIiwicmVwb093bmVyIjoiam9obmVudGhvbnlldmFucyIsInJlcG9OYW1lIjoiUGVvcGxlLURpcmVjdG9yeS0xIn0sImlhdCI6MTc3MTQzNjYyOCwiZXhwIjoxNzc0MDI4NjI4fQ.yZR_LrD_2JfIm9EMplQ6pGQ28AB-mVK6-B5GsqkyEji0xojsqSOm46oKBvb_y4lzTF4JqQOjMxWPApIjqrWJv8J7-If9sj0maGKA2N5X5d2Nodp-dJZl5EQxpPlWbbrGKOGAS-GmxwrbHQIiq14ooiav36UmFrxpUr443N4JSCx46xW2NWB7LiKKQpGNgXBk-ykd2i75QG9942_kY1zCVzffStzGiTOGTkf4IwCFK1hGVU-I3f2Sj_vyQYe-XzH2Ca6UE-VhVpycyQ65G27mZYcs9uKFyVN6dzkjs1p1AQ74dmiyGy9AhEujZt5GK4y5DIUKdhXfcwRRuSdgHYN_4g" target="_blank" rel="noopener noreferrer"><picture><source media="(prefers-color-scheme: dark)" srcset=".drift/prs/1/assets/asset-1.png"><source media="(prefers-color-scheme: light)" srcset=".drift/prs/1/assets/asset-2.png"><img alt="Fix in Cursor" width="115" height="28" src=".drift/prs/1/assets/asset-1.png"></picture></a>&nbsp;<a href="https://cursor.com/agents?data=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6ImJ1Z2JvdC12MiJ9.eyJ2ZXJzaW9uIjoxLCJ0eXBlIjoiQlVHQk9UX0ZJWF9JTl9XRUIiLCJkYXRhIjp7InJlZGlzS2V5IjoiYnVnYm90OmUyNTQyMDBjLWY5MzktNDgzNC1iODVkLWZiM2UyYzE3NGM5MyIsImVuY3J5cHRpb25LZXkiOiJfdmt4ZVRqQWpBMWU0eXI5aE5kTHd3dmx3aWFYc0hLTzlUUjBEeW1pTmxzIiwiYnJhbmNoIjoiZmVhdC9wZW9wbGUtZGlyZWN0b3J5LXVpIiwicmVwb093bmVyIjoiam9obmVudGhvbnlldmFucyIsInJlcG9OYW1lIjoiUGVvcGxlLURpcmVjdG9yeS0xIiwicHJOdW1iZXIiOjEsImNvbW1pdFNoYSI6IjMyZDJiZTdhYWYzYjU1YTNjNTZlOTU5OTcwMzYwYmQxNWZhZjU2YTgiLCJwcm92aWRlciI6ImdpdGh1YiJ9LCJpYXQiOjE3NzE0MzY2MjgsImV4cCI6MTc3NDAyODYyOH0.IfuzJ6k0ftGZt7mPdR3dx-QITRvKCTW00CJPZy1wOgXe-ZPYUM64-Wy4ed9FnJLK9fkLexx0hwFNEVBD-su77PT0v7QqqBITjm1uKlmzjvcEPphfkrjsCaVjAxeMKNrlwgFvPM53-57_6uTzcXWJ8eE9UyAy-DST1lFqqTiNEStadazB11Edp251wlBtYd9H-TcyHiUaqsYQ1OJVuWfVG8rac-VodFoSNPOmKmqOFG_XJXcgVF4tGG4sBpB_pbCQ1Rr7W2jaxGuwluBZbvmMnyr_icHxJk-BLRxlqc3nAFT1E5U7A6_b6rvUvho3USTFTw9buva3viHC8Y3T4LZrkw" target="_blank" rel="noopener noreferrer"><picture><source media="(prefers-color-scheme: dark)" srcset=".drift/prs/1/assets/asset-3.png"><source media="(prefers-color-scheme: light)" srcset=".drift/prs/1/assets/asset-4.png"><img alt="Fix in Web" width="99" height="28" src=".drift/prs/1/assets/asset-3.png"></picture></a></p>

### @cursor[bot] — 2026-02-18T17:43:49Z


**People Directory 1/ContentView.swift:107**

### Row subtitle shows dangling separator for empty audience

**Medium Severity**

<!-- DESCRIPTION START -->
In `PersonRowView`, the subtitle is guarded by `!person.role.isEmpty` but unconditionally interpolates `"\(person.role) · \(person.audience)"`. Many people in the CSV have a role but an empty `audience`, producing visible text like "Product Design · " with a trailing dot-separator. The guard needs to also account for whether `audience` is empty, or the interpolation needs to conditionally include the separator.
<!-- DESCRIPTION END -->

<!-- BUGBOT_BUG_ID: ad651cb9-8488-42ff-8e7f-8e448e424894 -->

<!-- LOCATIONS START
People Directory 1/ContentView.swift#L95-L100
LOCATIONS END -->
<p><a href="https://cursor.com/open?data=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6ImJ1Z2JvdC12MiJ9.eyJ2ZXJzaW9uIjoxLCJ0eXBlIjoiQlVHQk9UX0ZJWF9JTl9DVVJTT1IiLCJkYXRhIjp7InJlZGlzS2V5IjoiYnVnYm90OmQxNmEyMjg5LWRmMmItNDE0Ni1hYzA2LTkwYWY2YzBhOTBkZiIsImVuY3J5cHRpb25LZXkiOiJjYThGQ1FzeERjNEl0RlY5NzlMRHJCWEZXR2VSaXNkWDJXWXpobXpMd2ljIiwiYnJhbmNoIjoiZmVhdC9wZW9wbGUtZGlyZWN0b3J5LXVpIiwicmVwb093bmVyIjoiam9obmVudGhvbnlldmFucyIsInJlcG9OYW1lIjoiUGVvcGxlLURpcmVjdG9yeS0xIn0sImlhdCI6MTc3MTQzNjYyOCwiZXhwIjoxNzc0MDI4NjI4fQ.pg7lCjDZ2NSGB_59J2B9PUVwiyv2z5WuLEhEtox7EcJPRiaPptrw5OD3sDIgJxaMye16WWevFkCVx2y04pB-GOopXqK7Amiufn5b2lYPYTwavybS8w7Aleag9eScfXIUf6R7T5Zp12RWrbIsiBiKMBKDoN7JtczDQy01NLwx0JusDzomVa6OvPS4B-mXfxOmkMDU59lqpbgWnnWUMWtKOoH6321YfJrEFZd0e88GOunbIQBWcaU9eyaWcjc_Klf8HIJBsZt8GSLH3PgoV6YnvWKMNVTbbekFJa4JztDlmzN3oQUqsZO8tX1R_RmBy9VwS-4ZUbINsRj1720RKvnENg" target="_blank" rel="noopener noreferrer"><picture><source media="(prefers-color-scheme: dark)" srcset=".drift/prs/1/assets/asset-1.png"><source media="(prefers-color-scheme: light)" srcset=".drift/prs/1/assets/asset-2.png"><img alt="Fix in Cursor" width="115" height="28" src=".drift/prs/1/assets/asset-1.png"></picture></a>&nbsp;<a href="https://cursor.com/agents?data=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6ImJ1Z2JvdC12MiJ9.eyJ2ZXJzaW9uIjoxLCJ0eXBlIjoiQlVHQk9UX0ZJWF9JTl9XRUIiLCJkYXRhIjp7InJlZGlzS2V5IjoiYnVnYm90OmQxNmEyMjg5LWRmMmItNDE0Ni1hYzA2LTkwYWY2YzBhOTBkZiIsImVuY3J5cHRpb25LZXkiOiJjYThGQ1FzeERjNEl0RlY5NzlMRHJCWEZXR2VSaXNkWDJXWXpobXpMd2ljIiwiYnJhbmNoIjoiZmVhdC9wZW9wbGUtZGlyZWN0b3J5LXVpIiwicmVwb093bmVyIjoiam9obmVudGhvbnlldmFucyIsInJlcG9OYW1lIjoiUGVvcGxlLURpcmVjdG9yeS0xIiwicHJOdW1iZXIiOjEsImNvbW1pdFNoYSI6IjMyZDJiZTdhYWYzYjU1YTNjNTZlOTU5OTcwMzYwYmQxNWZhZjU2YTgiLCJwcm92aWRlciI6ImdpdGh1YiJ9LCJpYXQiOjE3NzE0MzY2MjgsImV4cCI6MTc3NDAyODYyOH0.pfCjqZLjz9wCCZmwOLIqYXmR-eIYWVUmdl-QP2DSasdElqwtZUNdzK24qbDUpx4-e5z7tByETGeAGBvRqH8RspirU9yKA2_eqYQicfrDBLGV6bVAjOYmKHY8e6B8j_Oh8AnOdKVMmAoMXJhrN_gQFhhSS4i2Mdm-ooDznRhF7jcQsNLnkGAY3Bsnsd11XkGFuj0mwnH6XrAiq91tCytNPhZAzt36maktsGr_0OxF_ZIP20mv5GPChO2vXL0ZcwAtLMnmohLizqInIqyvH_AMPPeiVEB_odk8HoPXmUgZTOwprLFzOWBXrs51s07DLak5WgmOK06w8DH51fxCmZFguw" target="_blank" rel="noopener noreferrer"><picture><source media="(prefers-color-scheme: dark)" srcset=".drift/prs/1/assets/asset-3.png"><source media="(prefers-color-scheme: light)" srcset=".drift/prs/1/assets/asset-4.png"><img alt="Fix in Web" width="99" height="28" src=".drift/prs/1/assets/asset-3.png"></picture></a></p>

### @cursor[bot] — 2026-02-18T19:43:10Z


**People Directory 1/ContentView.swift**

### Case-sensitive sort misorders lowercase names in sections

**Low Severity**

<!-- DESCRIPTION START -->
The within-section sort uses `$0.fullName < $1.fullName`, which is case-sensitive. In Swift, lowercase letters have higher Unicode scalar values than uppercase, so names starting with a lowercase letter (e.g. `"bohdan Pshenychnyi"` and `"yvon"` in the CSV) sort *after* all uppercase names in their section, instead of alphabetically among them. The search filter already uses `localizedCaseInsensitiveContains`, so the sort is inconsistent with that intent. Using `localizedCaseInsensitiveCompare` would produce the expected alphabetical ordering.
<!-- DESCRIPTION END -->

<!-- BUGBOT_BUG_ID: 7e11421f-eb04-4c1b-be91-850cec40aa8a -->

<!-- LOCATIONS START
People Directory 1/ContentView.swift#L43-L44
LOCATIONS END -->
<p><a href="https://cursor.com/open?data=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6ImJ1Z2JvdC12MiJ9.eyJ2ZXJzaW9uIjoxLCJ0eXBlIjoiQlVHQk9UX0ZJWF9JTl9DVVJTT1IiLCJkYXRhIjp7InJlZGlzS2V5IjoiYnVnYm90OmE1NWZjNmQzLTc1NWQtNGNlNy1iOGFlLTVjZjFjNDhiOGYyMyIsImVuY3J5cHRpb25LZXkiOiJnU2E2b0c5UmhEel8tNDRvMXB1azRhalpoaU9oOG9MZFRHY0RaUUJUT09NIiwiYnJhbmNoIjoiZmVhdC9wZW9wbGUtZGlyZWN0b3J5LXVpIiwicmVwb093bmVyIjoiam9obmVudGhvbnlldmFucyIsInJlcG9OYW1lIjoiUGVvcGxlLURpcmVjdG9yeS0xIn0sImlhdCI6MTc3MTQ0Mzc4OSwiZXhwIjoxNzc0MDM1Nzg5fQ.zLW1XmKse4wsXD0XWY_OdJc193T1CSz_i_tU0eKOLhIMpUd1DYldAbWjaPsGThMFNpnjFAwezlAwjCoyYIzMH9VqMIngpND20z3uoCggqpMXFOGo2dTj5Bd-ZOZVlMjh7XUvll8T678eFuPTB_E5VJo5kl3kfs_4epUXG62f3JR865d5-A6M7YxUSDzzboga7NAvTg76VHvVnUq0wnfvhlNvU5G9LMOLNVbcBZIRhItqcM0otDcJEYTIAGvqjQlX_6KBc5yIat9xnlawwlPKeDr2gPcgJwKoTOHKwC41NGqikpx3DcXCywTPVcFfNGGpAK2SCd9M9ATAwhYrSxUShw" target="_blank" rel="noopener noreferrer"><picture><source media="(prefers-color-scheme: dark)" srcset=".drift/prs/1/assets/asset-1.png"><source media="(prefers-color-scheme: light)" srcset=".drift/prs/1/assets/asset-2.png"><img alt="Fix in Cursor" width="115" height="28" src=".drift/prs/1/assets/asset-1.png"></picture></a>&nbsp;<a href="https://cursor.com/agents?data=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6ImJ1Z2JvdC12MiJ9.eyJ2ZXJzaW9uIjoxLCJ0eXBlIjoiQlVHQk9UX0ZJWF9JTl9XRUIiLCJkYXRhIjp7InJlZGlzS2V5IjoiYnVnYm90OmE1NWZjNmQzLTc1NWQtNGNlNy1iOGFlLTVjZjFjNDhiOGYyMyIsImVuY3J5cHRpb25LZXkiOiJnU2E2b0c5UmhEel8tNDRvMXB1azRhalpoaU9oOG9MZFRHY0RaUUJUT09NIiwiYnJhbmNoIjoiZmVhdC9wZW9wbGUtZGlyZWN0b3J5LXVpIiwicmVwb093bmVyIjoiam9obmVudGhvbnlldmFucyIsInJlcG9OYW1lIjoiUGVvcGxlLURpcmVjdG9yeS0xIiwicHJOdW1iZXIiOjEsImNvbW1pdFNoYSI6ImVkZGY1NWIzZjQzNmE0YTBkODA3ZmI3ZDUxMGYwZjA5M2MzNTU2NTAiLCJwcm92aWRlciI6ImdpdGh1YiJ9LCJpYXQiOjE3NzE0NDM3ODksImV4cCI6MTc3NDAzNTc4OX0.LOswwTDjWxJAWYTVnhEv2XTtWKOsrolHqDDtCBsiq33ARygZCV8UJTEco4WfE6qm0bgeZNfa0btzGI2E09I81OBgO1JD5nF11ZcX5DrEiG6nL95QDIsgqIr_bevj5gySfkQdbCYC6CT66cI9zL7XHQ8Y-9xCw5iyuSCw-pTLa4IPd5yo1FzdMMLluOikGeblDhXLQblTYIANeEAvJJzTfdplJx6-0Xgxd7vnEefjDPHNGXaCcXEJIYdmV8M508vWtALsj_e1rUGE3DYh8GalfEuGMint2VUAeupb_N_uf0fZoVYHTjoTEchRvcu80XqjAvWvi7pqxiYFAIMcnDecLw" target="_blank" rel="noopener noreferrer"><picture><source media="(prefers-color-scheme: dark)" srcset=".drift/prs/1/assets/asset-3.png"><source media="(prefers-color-scheme: light)" srcset=".drift/prs/1/assets/asset-4.png"><img alt="Fix in Web" width="99" height="28" src=".drift/prs/1/assets/asset-3.png"></picture></a></p>

### @cursor[bot] — 2026-02-18T20:07:38Z


**People Directory 1/Person.swift:23**

### Initials show bracket for contractor-suffixed names

**Low Severity**

<!-- DESCRIPTION START -->
The `initials` computed property uses `parts.last?.first` to get the last-name initial. Three people in the bundled CSV have a `[C]` contractor suffix (e.g. `Linea Högberg [C]`), so `parts.last` is `"[C]"` and its `.first` character is `"["`. This produces initials like `"L["` instead of `"LH"`, displaying a bracket character in both the list row and detail view avatar circles.
<!-- DESCRIPTION END -->

<!-- BUGBOT_BUG_ID: b781a58e-52f8-4e9e-9cf1-bf873a1f9f89 -->

<!-- LOCATIONS START
People Directory 1/Person.swift#L16-L23
LOCATIONS END -->
<p><a href="https://cursor.com/open?data=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6ImJ1Z2JvdC12MiJ9.eyJ2ZXJzaW9uIjoxLCJ0eXBlIjoiQlVHQk9UX0ZJWF9JTl9DVVJTT1IiLCJkYXRhIjp7InJlZGlzS2V5IjoiYnVnYm90OmExNzM5ZmNiLWVjOGItNDM2Ni1iM2QxLTIyZjBiZTZmMmZmYyIsImVuY3J5cHRpb25LZXkiOiJKNnRqYmJuZlNscUtNd1JtOWtXemZmSnZZZ3NYME41S04tYmZTc0lXckQwIiwiYnJhbmNoIjoiZmVhdC9wZW9wbGUtZGlyZWN0b3J5LXVpIiwicmVwb093bmVyIjoiam9obmVudGhvbnlldmFucyIsInJlcG9OYW1lIjoiUGVvcGxlLURpcmVjdG9yeS0xIn0sImlhdCI6MTc3MTQ0NTI1OCwiZXhwIjoxNzc0MDM3MjU4fQ.jO6-_jSQaQn58dAirnFv24xYPcZ6ZNusZRyxRRcDq7A_PzQPjZSKDSxUKN-0rXr7UwT4C7UhpeFy0SzacUrofChU3r8JQpmV1Z4wmCjhokwT3wfM9feVQJnwV3Bkyh1L1BxGVWTDw-SPLzh_RndzTDm3bCIidtsb88Kke6TDZA-_qt27xa8MybTxWQFIFbRy2xDZqOPjEtBZfSmuvhWkSwzlZ9Ut88KwcsG-avhAhbYhhM6PdTOGdoQmhDefKT65T8NdaWk9iRo20aoGpJcIHn3RUNDOky19-hycFmNXazqAgptIu54hjnIX-PyfDT5C0X_VkEUOpZV0s-EBckm-hg" target="_blank" rel="noopener noreferrer"><picture><source media="(prefers-color-scheme: dark)" srcset=".drift/prs/1/assets/asset-1.png"><source media="(prefers-color-scheme: light)" srcset=".drift/prs/1/assets/asset-2.png"><img alt="Fix in Cursor" width="115" height="28" src=".drift/prs/1/assets/asset-1.png"></picture></a>&nbsp;<a href="https://cursor.com/agents?data=eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6ImJ1Z2JvdC12MiJ9.eyJ2ZXJzaW9uIjoxLCJ0eXBlIjoiQlVHQk9UX0ZJWF9JTl9XRUIiLCJkYXRhIjp7InJlZGlzS2V5IjoiYnVnYm90OmExNzM5ZmNiLWVjOGItNDM2Ni1iM2QxLTIyZjBiZTZmMmZmYyIsImVuY3J5cHRpb25LZXkiOiJKNnRqYmJuZlNscUtNd1JtOWtXemZmSnZZZ3NYME41S04tYmZTc0lXckQwIiwiYnJhbmNoIjoiZmVhdC9wZW9wbGUtZGlyZWN0b3J5LXVpIiwicmVwb093bmVyIjoiam9obmVudGhvbnlldmFucyIsInJlcG9OYW1lIjoiUGVvcGxlLURpcmVjdG9yeS0xIiwicHJOdW1iZXIiOjEsImNvbW1pdFNoYSI6IjgxZTFlZmRmMjQ4Njg0MTBmODU0ZmViMDFiMDYwMTc4MGM0MWY0ZjciLCJwcm92aWRlciI6ImdpdGh1YiJ9LCJpYXQiOjE3NzE0NDUyNTgsImV4cCI6MTc3NDAzNzI1OH0.tPWqn8LFmhHMu4yioarRcIq3XaOL7I8-AnXgAEfrNmbqEa06ocHVoN1DdOg3XDO7_1GWiTE2muHx3eL8n278GeXGhb2h-3XAZrxH1ZyPLlamHLj4JOLIh0f_wzNbqTkwrmOmHh5_tmH-OxTh3dLUOs6sAi1cgBH6Wz2gJkfZSAILDPkOBne1-EvNj50xQi2ms4h_yJMpeKwaEDPwxJm7ZYjx9NqzaPErgXGD2NSUzYHep9AbSjGUumUhHt2rDxCgtC7DnMwjk9c-1DiXo9lShArQQFloMufHkxEM-HkZB589ZoKskjwAKdrgwSGfnP2mjZ03XFzXuaALtGdBlJ1zFQ" target="_blank" rel="noopener noreferrer"><picture><source media="(prefers-color-scheme: dark)" srcset=".drift/prs/1/assets/asset-3.png"><source media="(prefers-color-scheme: light)" srcset=".drift/prs/1/assets/asset-4.png"><img alt="Fix in Web" width="99" height="28" src=".drift/prs/1/assets/asset-3.png"></picture></a></p>

### @matej-doordash — 2026-02-18T18:08:23Z


I think the profile picture needs in the profile view needs a bit of a breathing room

### @matej-doordash — 2026-02-18T21:17:18Z


Levels should maybe be displayed on the main list


## PR Description

Hey I think this is a bit basic, but does the job, what should I add?

Add a people directory that loads from CSV, displays a searchable list with initials avatars, and navigates to a detail view with level, role, country, and audience.

[Watch a detailed screen recording](.drift/prs/1/assets/asset-19.mp4)

<img src=".drift/prs/1/assets/asset-20.png" width="300" />
> [8s] The People list view showing each person with their initials, role, and audience.

<img src=".drift/prs/1/assets/asset-21.png" width="300" />
> [17s] Scrolling through the full list — it shows everyone loaded from the CSV.

<img src=".drift/prs/1/assets/asset-22.png" width="300" />
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
> Introduces new CSV parsing and a large bundled dataset that now drives list grouping/sorting, so malformed rows or unexpected values could cause missing or misordered entries.
> 
> **Overview**
> Adds an in-app **People directory** backed by a bundled `people.csv`, including a new `Person` model and `PeopleData.load()` CSV parser.
> 
> Replaces the placeholder UI with a searchable `NavigationStack` list that can be grouped via a segmented control (Name/Level/Location), navigates to a person detail view, and includes UX/data fixes (numeric Level section ordering, case-insensitive name sorting, cleaner role/audience subtitle formatting, level badge in rows, and contractor-suffix-safe initials).
> 
> <sup>Written by [Cursor Bugbot](https://cursor.com/dashboard?tab=bugbot) for commit 1d669383f697bf6923ef435c7b4d6169b7678a9d. This will update automatically on new commits. Configure [here](https://cursor.com/dashboard?tab=bugbot).</sup>
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
