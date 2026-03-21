/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:flutter_test/flutter_test.dart';
import 'package:mindful/providers/restrictions/bedtime_provider.dart';
import 'package:mindful/core/utils/default_models_utils.dart';

void main() {
  group('BedtimeScheduleNotifier', () {
    test('setHardLockOn should update the state', () {
      final notifier = BedtimeScheduleNotifier();
      
      expect(notifier.state.isHardLockOn, isFalse);
      
      notifier.setHardLockOn(true);
      expect(notifier.state.isHardLockOn, isTrue);
      
      notifier.setHardLockOn(false);
      expect(notifier.state.isHardLockOn, isFalse);
    });
  });
}
