/*
 *
 *  * Copyright (c) 2024 Mindful (https://github.com/akaMrNagar/Mindful)
 *  * Author : Pawan Nagar (https://github.com/akaMrNagar)
 *  *
 *  * This source code is licensed under the GPL-2.0 license license found in the
 *  * LICENSE file in the root directory of this source tree.
 *
 */

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindful/core/database/app_database.dart';
import 'package:mindful/core/enums/break_cycle.dart';
import 'package:mindful/core/enums/break_reset_type.dart';
import 'package:mindful/core/enums/item_position.dart';
import 'package:mindful/core/extensions/ext_build_context.dart';
import 'package:mindful/core/extensions/ext_num.dart';
import 'package:mindful/providers/restrictions/apps_restrictions_provider.dart';
import 'package:mindful/ui/common/default_dropdown_tile.dart';
import 'package:mindful/ui/common/default_expandable_list_tile.dart';
import 'package:mindful/ui/common/default_list_tile.dart';
import 'package:mindful/ui/common/styled_text.dart';

class AppResetTile extends ConsumerWidget {
  const AppResetTile({
    super.key,
    required this.appPackage,
    required this.restriction,
  });

  final String appPackage;
  final AppRestriction restriction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultExpandableListTile(
      position: ItemPosition.mid,
      leadingIcon: FluentIcons.arrow_sync_20_regular,
      titleText: context.locale.app_reset_type_tile_title,
      subtitleText: _getResetSubtitle(context),
      content: Column(
        children: [
          /// Reset type
          DefaultDropdownTile<BreakResetType>(
            position: ItemPosition.mid,
            value: restriction.resetType,
            titleText: context.locale.app_reset_type_tile_title,
            leadingIcon: FluentIcons.arrow_sync_20_regular,
            onSelected: (type) => ref
                .read(appsRestrictionsProvider.notifier)
                .updateResetType(appPackage, type),
            items: [
              DefaultDropdownItem(
                label: context.locale.app_reset_type_tomorrow,
                value: BreakResetType.tomorrow,
              ),
              DefaultDropdownItem(
                label: context.locale.app_reset_type_cycle,
                value: BreakResetType.cycle,
              ),
              DefaultDropdownItem(
                label: context.locale.app_reset_type_custom,
                value: BreakResetType.custom,
              ),
            ],
          ),

          /// Cycle selection
          if (restriction.resetType == BreakResetType.cycle)
            DefaultDropdownTile<BreakCycle>(
              position: ItemPosition.mid,
              value: restriction.resetCycle,
              titleText: context.locale.app_reset_type_cycle,
              leadingIcon: FluentIcons.clock_20_regular,
              onSelected: (cycle) => ref
                  .read(appsRestrictionsProvider.notifier)
                  .updateResetCycle(appPackage, cycle),
              items: [
                DefaultDropdownItem(
                  label: context.locale.app_reset_cycle_early_night,
                  value: BreakCycle.earlyNight,
                ),
                DefaultDropdownItem(
                  label: context.locale.app_reset_cycle_morning,
                  value: BreakCycle.morning,
                ),
                DefaultDropdownItem(
                  label: context.locale.app_reset_cycle_afternoon,
                  value: BreakCycle.afternoon,
                ),
                DefaultDropdownItem(
                  label: context.locale.app_reset_cycle_evening,
                  value: BreakCycle.evening,
                ),
              ],
            ),

          /// Custom minutes
          if (restriction.resetType == BreakResetType.custom)
            DefaultListTile(
              position: ItemPosition.mid,
              leadingIcon: FluentIcons.timer_20_regular,
              titleText: context.locale.app_reset_custom_mins_title,
              trailing: StyledText(
                "${restriction.resetCustomMins}m",
                fontSize: 16,
              ),
              onPressed: () async {
                final result = await showDialog<int>(
                  context: context,
                  builder: (context) => _CustomMinsDialog(
                    initialValue: restriction.resetCustomMins,
                  ),
                );
                if (result != null) {
                  ref
                      .read(appsRestrictionsProvider.notifier)
                      .updateResetCustomMins(appPackage, result);
                }
              },
            ),
        ],
      ),
    );
  }

  String _getResetSubtitle(BuildContext context) {
    switch (restriction.resetType) {
      case BreakResetType.tomorrow:
        return context.locale.app_reset_type_tomorrow;
      case BreakResetType.cycle:
        switch (restriction.resetCycle) {
          case BreakCycle.earlyNight:
            return context.locale.app_reset_cycle_early_night;
          case BreakCycle.morning:
            return context.locale.app_reset_cycle_morning;
          case BreakCycle.afternoon:
            return context.locale.app_reset_cycle_afternoon;
          case BreakCycle.evening:
            return context.locale.app_reset_cycle_evening;
        }
      case BreakResetType.custom:
        return "${restriction.resetCustomMins}m break";
    }
  }
}

class _CustomMinsDialog extends StatefulWidget {
  const _CustomMinsDialog({required this.initialValue});
  final int initialValue;

  @override
  State<_CustomMinsDialog> createState() => _CustomMinsDialogState();
}

class _CustomMinsDialogState extends State<_CustomMinsDialog> {
  late int value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.locale.app_reset_custom_mins_title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Slider(
            value: value.toDouble(),
            min: 0,
            max: 1440, // 24 hours
            divisions: 1440 ~/ 5,
            label: "${value}m",
            onChanged: (v) => setState(() => value = v.toInt()),
          ),
          Text("${value ~/ 60}h ${value % 60}m"),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(context.locale.dialog_button_cancel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, value),
          child: Text(context.locale.dialog_button_set),
        ),
      ],
    );
  }
}
