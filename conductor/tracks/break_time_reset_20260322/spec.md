# Specification: Break Time for App Timer and Launch Limit Reset

## Overview
Implement a feature to allow users to set a "break time" or "reset cycle" for app-specific restrictions (Timer and Launch Limit). This allows for more flexible control over when limits are reset, beyond the default "tomorrow" (midnight).

## Problem Description
- Currently, app timers and launch limits likely reset at midnight.
- Users want to defer resets until a specific time (break time) or a specific cycle (e.g., Morning, Afternoon).
- Users also want a "Transparent Mode" (ghost mode) that applies only to a single app.

## Functional Requirements
- **Flexible Reset Options:**
    - **Default:** Reset tomorrow (midnight).
    - **Cycle Reset:** Choose between:
        - Early Night (00:00)
        - Morning
        - Afternoon
        - Evening
    - **Custom Reset:** Specify a "break" duration in minutes or hours before the limit resets.
- **App-Specific Scope:** These reset options must be configurable per app.
- **Transparent Mode:** Implement a mode (potentially named "Transparent Mode" or similar) that applies restrictions only to a specific app, making it "transparent" to others.
- **Database Updates:** Update `AppRestrictionTable` to store these new reset configurations.
- **UI Updates:** Provide a way in the App Dashboard or Restriction settings to configure these reset options.

## Technical Requirements
- Update `AppRestriction` model and `AppRestrictionTable`.
- Update `AppsRestrictionsProvider` to handle new logic.
- Update native side (if necessary) to respect the new reset times/cycles.
- Add UI components for selecting reset type and values.

## Acceptance Criteria
- [ ] Users can select "Tomorrow", "Cycle", or "Custom" reset for an app's timer and launch limit.
- [ ] "Cycle" options include Early Night, Morning, Afternoon, Evening.
- [ ] "Custom" option allows input in minutes or hours.
- [ ] "Transparent Mode" can be enabled for a single app.
- [ ] Limits reset correctly according to the selected break time/cycle.
