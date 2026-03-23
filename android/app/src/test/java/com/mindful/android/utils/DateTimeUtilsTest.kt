package com.mindful.android.utils

import org.junit.Assert.assertEquals
import org.junit.Test
import java.util.*

class DateTimeUtilsTest {

    @Test
    fun `calculateResetStartTime tomorrow resets to 00-00 of current day`() {
        // Mock current time: 2026-03-22 10:30 AM
        val now = Calendar.getInstance().apply {
            set(2026, Calendar.MARCH, 22, 10, 30, 0)
            set(Calendar.MILLISECOND, 0)
        }.timeInMillis

        // resetType = 0 (Tomorrow), resetCycle = 0, resetCustomMins = 0
        // It should return 2026-03-22 00:00:00
        val resetStart = DateTimeUtils.calculateResetStartTime(0, 0, 0)
        
        val resultCal = Calendar.getInstance().apply { timeInMillis = resetStart }
        assertEquals(0, resultCal.get(Calendar.HOUR_OF_DAY))
        assertEquals(0, resultCal.get(Calendar.MINUTE))
        assertEquals(0, resultCal.get(Calendar.SECOND))
    }

    @Test
    fun `calculateResetStartTime cycle morning resets to 06-00`() {
        // Mock current time: 2026-03-22 10:30 AM
        // resetType = 1 (Cycle), resetCycle = 1 (Morning = 06:00)
        val resetStart = DateTimeUtils.calculateResetStartTime(1, 1, 0)
        
        val resultCal = Calendar.getInstance().apply { timeInMillis = resetStart }
        assertEquals(6, resultCal.get(Calendar.HOUR_OF_DAY))
        assertEquals(0, resultCal.get(Calendar.MINUTE))
    }

    @Test
    fun `calculateResetStartTime custom capped at midnight`() {
        // This test assumes current time is shortly after midnight, e.g., 00:05 AM
        // If we set a 30-minute custom break, it should cap at 00:00 AM today, not 11:35 PM yesterday.
        
        val nowCal = Calendar.getInstance()
        val hour = nowCal.get(Calendar.HOUR_OF_DAY)
        val minute = nowCal.get(Calendar.MINUTE)
        
        if (hour == 0 && minute < 30) {
            // resetType = 2 (Custom), resetCustomMins = 60 (1 hour)
            val resetStart = DateTimeUtils.calculateResetStartTime(2, 0, 60)
            val resultCal = Calendar.getInstance().apply { timeInMillis = resetStart }
            
            // Should be today at 00:00
            assertEquals(nowCal.get(Calendar.DAY_OF_YEAR), resultCal.get(Calendar.DAY_OF_YEAR))
            assertEquals(0, resultCal.get(Calendar.HOUR_OF_DAY))
            assertEquals(0, resultCal.get(Calendar.MINUTE))
        }
    }
}
