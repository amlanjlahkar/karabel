local manipulator = import 'helpers/manipulator.libsonnet';
local util = import 'helpers/util.libsonnet';

local mp = manipulator.call;
local hyper = util.key_hyper;
local set_var = util.set_var;
local if_app = util.if_app;
local if_var = util.if_var;

// bundle_identifiers for programs
// where capslock should act as control key
local bid = [
  '^com\\.apple\\.Terminal$',
  '^com\\.github\\.wez\\.wezterm$',
  '^com\\.mitchellh\\.ghostty$',
  '^org\\.alacritty$',
  '^info\\.sioyek\\.sioyek$',
  '^md\\.obsidian$',
  '^org\\.mozilla\\.firefox',
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
          c: [if_app(bid), if_var(var, false)],
          f: 'caps_lock',
          t: 'left_control',
        }),
        mp({
          c: [if_app(bid), if_var(var)],
          f: 'caps_lock',
          t: hyper(),
        }),
        mp({
          c: [if_app(bid), if_var(var, false)],
          f: { k: 'backslash', m: { m: 'left_control' } },
          t: { s: [set_var(var)] },
          td: { c: set_var(var, false), i: set_var(var, false) },
          p: { 'basic.to_delayed_action_delay_milliseconds': 5000 },
        }),
        mp({
          c: [if_app(bid), if_var(var)],
          f: { k: 'backslash', m: hyper(true).m },
          t: { s: [set_var(var, false)] },
        }),
      ],
    },
  ],
}

// vim:ai:
