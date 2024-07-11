// {{{1 Keybinds
// {{{2 Hyper
local hyper(mod_only=false) = {
  assert std.type(mod_only) == 'boolean',

  [if !mod_only then 'k']: 'left_shift',
  m: (if mod_only then ['left_shift'] else [])
     + [
       'left_control',
       'left_option',
       'left_command',
     ],
};
// 2}}}
// 1}}}

// {{{1 Setters
// {{{2 Variable
local set_var(name, value=1) = {
  set_variable: {
    name: name,
    value: value,
  },
};
// 2}}}
// 1}}}

// {{{1 Conditionals
// {{{2 Bundle identifiers
local if_app(bundles, is_frontmost) = {
  assert std.type(is_frontmost) == 'boolean' && std.type(bundles) == 'array',

  local type = if is_frontmost then 'frontmost_application_if' else 'frontmost_application_unless',

  bundle_identifiers: bundles,
  type: type,
};
// 2}}}
// {{{2 Variables
local if_var(name, active) = {
  assert std.type(name) == 'string' && std.type(active) == 'boolean',

  local type = if active then 'variable_if' else 'variable_unless',

  name: name,
  type: type,
  value: 1,

};
// 2}}}
// 1}}}

{
  key_hyper: hyper,
  set_var: set_var,
  if_app: if_app,
  if_var: if_var,
}

// vim:fdm=marker:ai:
