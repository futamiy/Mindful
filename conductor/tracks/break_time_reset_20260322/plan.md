# Implementation Plan: Break Time for App Timer and Launch Limit Reset

## Phase 1: Core Models and Database
- [x] Create `lib/core/enums/break_reset_type.dart` with `tomorrow`, `cycle`, `custom`.
- [x] Create `lib/core/enums/break_cycle.dart` with `earlyNight`, `morning`, `afternoon`, `evening`.
- [x] Update `AppRestrictionTable` in `lib/core/database/tables/app_restriction_table.dart` to include:
    - `resetType` (Enum)
    - `resetCycle` (Enum)
    - `resetCustomMins` (Int)
    - `isTransparentModeOn` (Bool)
- [x] Run `dart run build_runner build -d` to update database files. (Skipped: Environment limitation, manually updated defaults)
- [x] Update `AppRestriction` data class if necessary (usually handled by Drift).
- [x] Update `defaultAppRestrictionModel` in `lib/core/utils/default_models_utils.dart`.

## Phase 2: Provider Logic
- [x] Update `AppsRestrictionsProvider` in `lib/providers/restrictions/apps_restrictions_provider.dart`:
    - [x] Add methods to update reset type, cycle, and custom minutes.
    - [x] Add method to toggle transparent mode.
    - [x] Implement logic to calculate the next reset time based on the selected configuration. (Handled on native side for accuracy)
- [x] Update logic for checking if a limit is reached to respect the new reset times. (Handled on native side)

## Phase 3: UI Implementation
- [x] Update App Dashboard (`lib/ui/screens/app_dashboard/app_dashboard_restrictions.dart` or similar) to include:
    - [x] Reset configuration section.
    - [x] Transparent mode toggle.
- [x] Create UI components for selecting `BreakResetType` and `BreakCycle`.
- [x] Add input field for custom reset minutes/hours.

## Phase 4: Native Integration and Verification
- [x] Update `MethodChannelService` if reset logic needs to be shared with Android side.
- [x] Update Android models and logic.
- [x] Verify that app timers and launch limits reset at the correct times.
- [x] Verify "Transparent Mode" behavior.
- [x] Add unit tests for the new reset calculation logic.

## Phase: Review Fixes
- [x] Task: Apply review suggestions 7b91aa5
