local manipulator = import 'helpers/manipulator.libsonnet';
local util = import 'helpers/util.libsonnet';

local mp = manipulator.call;
local hyper = util.key_hyper;
local if_app = util.if_app;

{
  title: 'Program specific rules',
  rules: [
    {
      description: 'Progrule: Firefox',

      local bid = ['org\\.mozilla\\.firefox'],
      local manipulators = [
        mp({ f: { k: 'j', m: hyper(true).m }, t: { k: 'right_arrow', m: ['option', 'command'] } }),
        mp({ f: { k: 'k', m: hyper(true).m }, t: { k: 'left_arrow', m: ['option', 'command'] } }),
        mp({ f: { k: 'j', m: { m: 'left_command' } }, t: 'down_arrow' }),
        mp({ f: { k: 'k', m: { m: 'left_command' } }, t: 'up_arrow' }),
        mp({ f: { k: 'j', m: { m: ['left_shift', 'left_command'] } }, t: { k: 'down_arrow', m: ['command'] } }),
        mp({ f: { k: 'k', m: { m: ['left_shift', 'left_command'] } }, t: { k: 'up_arrow', m: ['command'] } }),
      ],

      manipulators: [m + { conditions: [if_app(bid)] } for m in manipulators],
    },
  ],
}

// vim:ai:
