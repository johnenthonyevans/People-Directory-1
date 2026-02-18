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


## PR Description

<!-- CURSOR_SUMMARY -->
> [!NOTE]
> **Low Risk**
> No changes; no impact on runtime behavior.
> 
> **Overview**
> No code changes are introduced in this PR (empty diff).
> 
> <sup>Written by [Cursor Bugbot](https://cursor.com/dashboard?tab=bugbot) for commit ca19a5c8812def86a2fd5c39f824a8aa9eebaf8a. This will update automatically on new commits. Configure [here](https://cursor.com/dashboard?tab=bugbot).</sup>
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
