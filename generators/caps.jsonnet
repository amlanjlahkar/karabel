local manipulator = import 'helpers/manipulator.libsonnet';
local util = import 'helpers/util.libsonnet';

local mp = manipulator.call;
local hyper = util.key_hyper;
local set_var = util.set_var;
local if_app = util.if_app;
local if_var = util.if_var;

// bundle_identifiers
local bid = [
  '^com\\.apple\\.Terminal$',
  '^com\\.github\\.wez\\.wezterm$',
  '^md\\.obsidian$',
];

{
  title: 'Use CapsLock as a modifier key',
  rules: [
    {
      description: 'Caps as hyper',
      manipulators: [
        mp({ f: 'caps_lock', t: hyper(), c: [if_app(bid, false)] }),
      ],
    },
    {
      local var = 'control_as_hyper',

      description: 'Caps as control',
      manipulators: [
        mp({
          f: 'caps_lock',
          t: 'left_control',
          c: [if_app(bid, true), if_var(var, false)],
        }),
        mp({
          f: 'caps_lock',
          t: hyper(),
          c: [if_app(bid, true), if_var(var, true)],
        }),
        mp({
          f: { k: 'backslash', m: { m: 'left_control' } },
          t: { v: [set_var(var)] },
          td: { c: set_var(var, 0), i: set_var(var, 0) },
          c: [if_app(bid, true), if_var(var, false)],
          p: { 'basic.to_delayed_action_delay_milliseconds': 5000 },
        }),
        mp({
          f: { k: 'backslash', m: hyper(true).m },
          t: { v: [set_var(var, 0)] },
          c: [if_app(bid, true), if_var(var, true)],
        }),
      ],
    },
  ],
}

// vim:ai:
