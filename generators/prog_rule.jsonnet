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
        mp({ f: { k: 'i', m: { m: 'left_control' } }, t: { k: 'right_arrow', m: ['option', 'command'] } }),
        mp({ f: { k: 'o', m: { m: 'left_control' } }, t: { k: 'left_arrow', m: ['option', 'command'] } }),
        /*
        mp({ f: { k: 'j', m: hyper(true).m }, t: 'down_arrow' }),
        mp({ f: { k: 'k', m: hyper(true).m }, t: 'up_arrow' }),
        mp({ f: { k: 'h', m: hyper(true).m }, t: 'left_arrow' }),
        mp({ f: { k: 'l', m: hyper(true).m }, t: 'right_arrow' }),
        mp({ f: { k: 'd', m: hyper(true).m }, t: { k: 'down_arrow', m: ['command'] } }),
        mp({ f: { k: 'u', m: hyper(true).m }, t: { k: 'up_arrow', m: ['command'] } }),
        mp({ f: { k: 'w', m: hyper(true).m }, t: { k: 'w', m: ['command'] } }),
        mp({ f: { k: 'n', m: hyper(true).m }, t: { k: 't', m: ['command'] } }),
        */
        // Expand sidebar when using vertical tabs
        // mp({ f: { k: 'z', m: hyper(true).m }, t: { k: 'z', m: ['left_control'] } }),
      ],

      manipulators: [m + { conditions: [if_app(bid)] } for m in manipulators],
    },
  ],
}

// vim:ai:
