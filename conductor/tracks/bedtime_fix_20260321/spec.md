# Specification: Bedtime Parental Control Fix

## Overview
A bug where the Bedtime Parental Control is bypassed after a few days or can be manually deactivated by the user. The goal is to ensure the bedtime restriction is persistent and cannot be disabled while active.

## Problem Description
- **Intermittent Failure:** Bedtime parental control works initially but fails after several days.
- **Bypass:** The user can currently deactivate the bedtime activation while it's in progress.
- **Target OS:** Android 15 (and potentially other versions).

## Functional Requirements
- **Persistent Blocking:** Ensure the background service/alarm responsible for bedtime remains active across system restarts and long periods.
- **Settings Hard Lock:** Implement a "Hard Lock" within the app that prevents the user from deactivating bedtime while it is active.
- **State Preservation:** The app must reliably track and enforce the bedtime state across app restarts.

## Non-Functional Requirements
- **Reliability:** The blocking mechanism must be robust against being killed by the OS (Android 15's power management).
- **Usability:** Provide clear feedback to the user when settings are locked during bedtime.

## Acceptance Criteria
- [ ] Bedtime restriction remains active and functional for multiple consecutive days.
- [ ] The option to deactivate bedtime is disabled or hidden when the bedtime period is active.
- [ ] The app correctly identifies the current time and applies the bedtime restriction based on the configured schedule.
- [ ] The fix is verified to work on Android 15.

## Out of Scope
- Full device lockdown (kiosk mode).
- Preventing app uninstallation (handled by existing Accessibility/Device Admin if applicable).
