local manipulator = import 'helpers/manipulator.libsonnet';
local util = import 'helpers/util.libsonnet';

local mp = manipulator.call;
local hyper = util.key_hyper;

local launch_prefix = 'q';
local param_simthreshold = { 'basic.simultaneous_threshold_milliseconds': 500 };

{
  title: 'Raycast shortcuts',
  rules: [
    {
      description: 'Raycast: Open dictionary',
      manipulators: [
        mp({
          p: param_simthreshold,
          f: { s: [launch_prefix, 'w'], so: { key_down_order: 'strict' }, m: hyper(true).m },
          t: { sc: 'open raycast://extensions/raycast/dictionary/define-word' },
        }),
      ],
    },
    {
      description: 'Raycast: Open clipboard history',
      manipulators: [
        mp({
          p: param_simthreshold,
          f: { s: [launch_prefix, 'l'], so: { key_down_order: 'strict' }, m: hyper(true).m },
          t: { sc: 'open raycast://extensions/raycast/clipboard-history/clipboard-history' },
        }),
      ],
    },
    {
      description: 'Raycast: Check reminders',
      manipulators: [
        mp({
          p: param_simthreshold,
          f: { s: [launch_prefix, 'x'], so: { key_down_order: 'strict' }, m: hyper(true).m },
          t: { sc: 'open raycast://extensions/raycast/apple-reminders/my-reminders' },
        }),
      ],
    },
    {
      description: 'Raycast: Kill process',
      manipulators: [
        mp({
          p: param_simthreshold,
          f: { s: [launch_prefix, 'k'], so: { key_down_order: 'strict' }, m: hyper(true).m },
          t: { sc: 'open raycast://extensions/rolandleth/kill-process/index' },
        }),
      ],
    },
    {
      description: 'Raycast: Seach files',
      manipulators: [
        mp({
          p: param_simthreshold,
          f: { s: [launch_prefix, 'semicolon'], so: { key_down_order: 'strict' }, m: hyper(true).m },
          t: { sc: 'open raycast://extensions/raycast/file-search/search-files' },
        }),
      ],
    },
  ],
}

// vim:ai:
