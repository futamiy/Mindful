# Implementation Plan: Bedtime Parental Control Fix

## Phase 1: Research & Reproduction
- [x] Task: Analyze current bedtime implementation (`lib/core/services/`, `lib/providers/focus/`).
- [x] Task: Reproduce the bypass on Android 15 (simulated or real device).
- [x] Task: Identify the cause of the intermittent failure after several days.
- [x] Task: Conductor - User Manual Verification 'Phase 1: Research & Reproduction' (Protocol in workflow.md)

## Phase 2: Core Logic Fix & Persistence
- [x] Task: Write tests for bedtime service persistence and scheduling.
- [x] Task: Implement a robust background scheduling mechanism for bedtime (e.g., using `AlarmManager` or `WorkManager`).
- [x] Task: Ensure the bedtime state is correctly saved and restored using the Drift database.
- [x] Task: Verify the fix with tests.
- [x] Task: Conductor - User Manual Verification 'Phase 2: Core Logic Fix & Persistence' (Protocol in workflow.md)

## Phase 3: Settings Hard Lock Implementation
- [x] Task: Write tests for the "Hard Lock" logic in the settings provider.
- [x] Task: Update the bedtime UI components to reflect the "Hard Lock" state (e.g., disable/hide deactivation toggles).
- [x] Task: Implement server-side (logic-side) validation to prevent deactivating bedtime when active.
- [x] Task: Verify the UI changes and lock logic.
- [x] Task: Conductor - User Manual Verification 'Phase 3: Settings Hard Lock Implementation' (Protocol in workflow.md)

## Phase 4: Final Verification & Quality Gates
- [x] Task: Perform long-term simulation tests (simulating multiple days) for bedtime stability.
- [x] Task: Run full project test suite and verify >80% coverage for new code.
- [x] Task: Final manual verification on Android 15.
- [x] Task: Conductor - User Manual Verification 'Phase 4: Final Verification & Quality Gates' (Protocol in workflow.md)
