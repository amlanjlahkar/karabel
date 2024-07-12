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
local set_var(name, value=true) = {
  assert std.type(name) == 'string' && std.type(value) == 'boolean',
  set_variable: {
    name: name,
    value: value,
  },
};
// 2}}}
// {{{2 Notification
local set_nf(id, text='') = {
  assert std.type(id) == 'string' && std.type(text) == 'string',
  set_notification_message: {
    id: id,
    text: text,
  },
};
// 2}}}
// 1}}}

// {{{1 Conditionals
// {{{2 Bundle identifiers
local if_app(bundles, is_frontmost=true) = {
  assert std.type(bundles) == 'array' && std.type(is_frontmost) == 'boolean',
  local type = if is_frontmost then 'frontmost_application_if' else 'frontmost_application_unless',
  bundle_identifiers: bundles,
  type: type,
};
// 2}}}
// {{{2 Variables
local if_var(name, set=true) = {
  assert std.type(name) == 'string' && std.type(set) == 'boolean',
  local type = if set then 'variable_if' else 'variable_unless',
  name: name,
  type: type,
  value: true,

};
// 2}}}
// 1}}}

{
  key_hyper: hyper,
  set_var: set_var,
  set_nf: set_nf,
  if_app: if_app,
  if_var: if_var,
}

// vim:fdm=marker:ai:
