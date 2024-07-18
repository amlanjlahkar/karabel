local manipulator = import 'helpers/manipulator.libsonnet';
local util = import 'helpers/util.libsonnet';

local mp = manipulator.call;
local hyper = util.key_hyper;
local map = util.key_map;

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
          f: { s: [launch_prefix, 'p'], so: { key_down_order: 'strict' }, m: hyper(true).m },
          t: { sc: 'open raycast://extensions/raycast/clipboard-history/clipboard-history' },
        }),
      ],
    },
  ],
}

// vim:ai:
