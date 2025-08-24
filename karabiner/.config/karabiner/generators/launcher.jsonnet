local manipulator = import 'helpers/manipulator.libsonnet';
local util = import 'helpers/util.libsonnet';

local mp = manipulator.call;
local hyper = util.key_hyper;

local launch_prefix = 'p';
local param_simthreshold = { 'basic.simultaneous_threshold_milliseconds': 500 };

{
  title: 'Launch Applications',
  rules: [
    {
      description: 'Launch: Browser',
      manipulators: [
        mp({
          p: param_simthreshold,
          f: { s: [launch_prefix, 'w'], so: { key_down_order: 'strict' }, m: hyper(true).m },
          t: { sc: 'export MOZ_DISABLE_SAFE_MODE_KEY=1; open /Applications/Firefox.app' },
        }),
      ],
    },
    {
      description: 'Launch: Terminal',
      manipulators: [
        mp({
          p: param_simthreshold,
          f: { s: [launch_prefix, 'x'], so: { key_down_order: 'strict' }, m: hyper(true).m },
          t: { sc: 'open /Applications/Alacritty.app' },
        }),
      ],
    },
    {
      description: 'Launch: Music',
      manipulators: [
        mp({
          p: param_simthreshold,
          f: { s: [launch_prefix, 'm'], so: { key_down_order: 'strict' }, m: hyper(true).m },
          t: { sc: 'open /System/Applications/Music.app' },
        }),
      ],
    },
    {
      description: 'Launch: Project Progress',
      manipulators: [
        mp({
          p: param_simthreshold,
          f: { s: ['s', 'p'], so: { key_down_order: 'strict' }, m: hyper(true).m },
          t: { sc: '/opt/homebrew/bin/wezterm start --class scratch.project-progress --cwd ~/Projects/minor_project_mca /Users/amlan/.local/share/bob/nvim-bin/nvim daily_progress.md' },
        }),
      ],
    },
  ],
}

// vim:ai:
