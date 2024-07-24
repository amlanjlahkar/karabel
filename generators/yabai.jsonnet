local manipulator = import 'helpers/manipulator.libsonnet';
local util = import 'helpers/util.libsonnet';

local mp = manipulator.call;
local hyper = util.key_hyper;
local map = util.key_map;
local set_var = util.set_var;
local set_nf = util.set_nf;
local if_var = util.if_var;

local yabai = '/opt/homebrew/bin/yabai';
local exec = "export PATH='/opt/homebrew/bin:/opt/homebrew/sbin:$PATH'; /bin/sh -c";

{
  title: 'Yabai keybinds',
  rules: [
    {
      description: 'Yabai: Window control mode',

      local var = 'win_ctrl_mode',
      local nid = 'yabai.win_ctrl_mode',
      local wt = yabai + ' -m window --toggle',

      manipulators: [
        mp({
          c: [if_var(var, false)],
          f: { k: 'w', m: hyper(true).m },
          t: { s: [set_var(var), set_nf(nid, 'Yabai: Window control mode active(Hyper+W)')] },
        }),
        mp({
          c: [if_var(var)],
          f: { k: 'w', m: hyper(true).m },
          t: { s: [set_var(var, false), set_nf(nid)] },
        }),
        mp({
          c: [if_var(var)],
          f: 'escape',
          t: { s: [set_var(var, false), set_nf(nid)] },
        }),
        mp({
          c: [if_var(var)],
          f: { k: 'j', m: { m: 'left_shift' } },
          t: { sc: exec + '~/config/yabai/scripts/yabai_swap_win' },
        }),
        mp({
          c: [if_var(var)],
          f: { k: 'k', m: { m: 'left_shift' } },
          t: { sc: exec + '~/config/yabai/scripts/yabai_swap_win_anti' },
        }),
      ] + map(['var', var], {
        '0': yabai + '-m space --balance',
        p: wt + ' split',
        z: wt + ' zoom-fullscreen',
        f: wt + ' native-fullscreen',
        s: wt + ' sticky',
        spacebar: wt + ' float --grid 4:4:1:1:5:5',
      }),
    },

    {
      description: 'Yabai: Window resize mode',

      local var = 'win_resize_mode',
      local nid = 'yabai.win_resize_mode',
      local wr = yabai + ' -m window --resize',

      manipulators: [
        mp({
          c: [if_var(var, false)],
          f: { k: 'r', m: { m: hyper(true).m } },
          t: { s: [set_var(var), set_nf(nid, 'Yabai: Window resize mode active(Hyper+R)')] },
        }),
        mp({
          c: [if_var(var)],
          f: { k: 'r', m: { m: hyper(true).m } },
          t: { s: [set_var(var, false), set_nf(nid)] },
        }),
        mp({
          c: [if_var(var)],
          f: 'escape',
          t: { s: [set_var(var, false), set_nf(nid)] },
        }),
      ] + map(['var', var], {
        h: wr + ' right:-20:0',
        j: wr + ' right:0:20',
        k: wr + ' right:0:-20',
        l: wr + ' right:20:0',
        equal_sign: yabai + ' -m space --equalize',
      }),
    },

    {
      description: 'Yabai: Movements',

      local wf = yabai + ' -m window --focus',
      local sf = yabai + ' -m space --focus',
      local wm(space) = '%s -m window --space %d; %s %d' % [yabai, space, sf, space],

      manipulators: map(['mod', 'left_option'], {
        j: '%(wf)s next || %(wf)s first' % { wf: wf },
        k: '%(wf)s prev || %(wf)s last' % { wf: wf },
        open_bracket: '%(sf)s prev || %(sf)s last' % { sf: sf },
        close_bracket: '%(sf)s next || %(sf)s first' % { sf: sf },
        tab: sf + ' recent',
      }) + map(['mod', 'left_option'], {
        '8': sf + ' 1',
        '9': sf + ' 2',
        '0': sf + ' 3',
        hyphen: sf + ' 4',
        equal_sign: sf + ' 5',
      }) + map(['mod', hyper(true).m], {
        '8': wm(1),
        '9': wm(2),
        '0': wm(3),
        hyphen: wm(4),
        equal_sign: wm(5),
        open_bracket: '%(y)s -m window --space prev; %(y)s -m space --focus prev' % { y: yabai },
        close_bracket: '%(y)s -m window --space next; %(y)s -m space --focus next' % { y: yabai },
      }),
    },
  ],
}


// vim:ai:
