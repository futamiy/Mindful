package com.mindful.android.services.accessibility

import android.content.Context
import android.view.accessibility.AccessibilityNodeInfo
import com.mindful.android.AppConstants.SYSTEM_SETTINGS_PACKAGE
import com.mindful.android.R
import com.mindful.android.helpers.device.PermissionsHelper
import com.mindful.android.models.Wellbeing

class DeviceFeaturesManager(
    private val context: Context,
    private val blockedContentGoBack: () -> Unit,
) {

    /**
     * Checks if a blocked feature is open and applies restrictions.
     *
     * @param packageName The package name of the current app in focus.
     * @param node The root `AccessibilityNodeInfo` of the current screen.
     * @param wellbeing The user's `WellBeingSettings`.
     */
    fun blockFeatures(
        packageName: String,
        node: AccessibilityNodeInfo,
        wellbeing: Wellbeing,
    ) {

        /// Check if blocking is enabled for platforms
        val isFeatureOpen = when (packageName) {
            SYSTEM_SETTINGS_PACKAGE -> isSettingsTamperFeatureOpen(context, node)

            else -> false
        }

        if (isFeatureOpen) {
            blockedContentGoBack.invoke()
        }
    }

    companion object {
        /**
         * Checks if Device Settings features (Admin or Accessibility) are open for mindful.
         * Also checks if the App Info page for Mindful is open to prevent force-stopping.
         */
        private fun isSettingsTamperFeatureOpen(
            context: Context,
            node: AccessibilityNodeInfo,
        ): Boolean {
            val appName: String = context.getString(R.string.app_name)
            val packageName: String = context.packageName

            // Check for Admin section
            val isAdminSectionOpen =
                node.findAccessibilityNodeInfosByViewId("com.android.settings:id/admin_name")
                    .firstOrNull()?.text == appName


            // Check for Accessibility section
            val isAccessibilitySectionOpen =
                node.findAccessibilityNodeInfosByText(context.getString(R.string.accessibility_description))
                    .isNotEmpty() &&
                        node.findAccessibilityNodeInfosByText(appName)
                            .any { it.text == appName }

            // Check for App Info page for Mindful
            val isAppInfoPageOpen = node.packageName == SYSTEM_SETTINGS_PACKAGE &&
                    node.findAccessibilityNodeInfosByText(appName).isNotEmpty()

            val isBedtimeLocked = SharedPrefsHelper.getSetIsBedtimeActive(context, null) &&
                    SharedPrefsHelper.getSetIsBedtimeHardLocked(context, null)

            val isFocusActive = SharedPrefsHelper.getSetIsFocusActive(context, null)

            if (isAppInfoPageOpen && (isBedtimeLocked || isFocusActive)) {
                Log.d("Mindful.DeviceFeaturesManager", "isSettingsTamperFeatureOpen: Blocking App Info page during active session")
                return true
            }

            return (isAdminSectionOpen || isAccessibilitySectionOpen) &&
                    PermissionsHelper.getAndAskAdminPermission(context, false)
        }
    }
}