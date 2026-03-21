# Implementation Plan: Bedtime Parental Control Fix

## Phase 1: Research & Reproduction
- [ ] Task: Analyze current bedtime implementation (`lib/core/services/`, `lib/providers/focus/`).
- [ ] Task: Reproduce the bypass on Android 15 (simulated or real device).
- [ ] Task: Identify the cause of the intermittent failure after several days.
- [ ] Task: Conductor - User Manual Verification 'Phase 1: Research & Reproduction' (Protocol in workflow.md)

## Phase 2: Core Logic Fix & Persistence
- [ ] Task: Write tests for bedtime service persistence and scheduling.
- [ ] Task: Implement a robust background scheduling mechanism for bedtime (e.g., using `AlarmManager` or `WorkManager`).
- [ ] Task: Ensure the bedtime state is correctly saved and restored using the Drift database.
- [ ] Task: Verify the fix with tests.
- [ ] Task: Conductor - User Manual Verification 'Phase 2: Core Logic Fix & Persistence' (Protocol in workflow.md)

## Phase 3: Settings Hard Lock Implementation
- [ ] Task: Write tests for the "Hard Lock" logic in the settings provider.
- [ ] Task: Update the bedtime UI components to reflect the "Hard Lock" state (e.g., disable/hide deactivation toggles).
- [ ] Task: Implement server-side (logic-side) validation to prevent deactivating bedtime when active.
- [ ] Task: Verify the UI changes and lock logic.
- [ ] Task: Conductor - User Manual Verification 'Phase 3: Settings Hard Lock Implementation' (Protocol in workflow.md)

## Phase 4: Final Verification & Quality Gates
- [ ] Task: Perform long-term simulation tests (simulating multiple days) for bedtime stability.
- [ ] Task: Run full project test suite and verify >80% coverage for new code.
- [ ] Task: Final manual verification on Android 15.
- [ ] Task: Conductor - User Manual Verification 'Phase 4: Final Verification & Quality Gates' (Protocol in workflow.md)
