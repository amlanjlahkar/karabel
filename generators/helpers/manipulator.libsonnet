local get(key, f) = if std.isObject(key) && std.objectHas(key, f) then key[f] else null;

// {{{1 "from" event
local genFrom(f) = {
  local fk = get(f, 'k'),  // from.key_code
  local fs = get(f, 's'),  // from.simultaneous
  local fm = get(f, 'm'),  // from.modifiers
  local fmm = get(fm, 'm'),  // from.modifiers.mandatory
  local fmo = get(fm, 'o'),  // from.modifiers.optional

  key_code: if std.type(fk) == 'string' then fk,

  simultaneous: if std.type(fs) == 'array' then [{ key_code: k } for k in fs],
  simultaneous_options: if self.simultaneous != null then get(f, 'so'),

  modifiers: if fmm != null then
    { mandatory: fmm } + (if fmo != null then { optional: fmo } else {})
  else (if fm != null && std.isArray(fm) then { mandatory: fm }),
} + {
  key_code: if super.key_code == null && std.isString(f) then f else super.key_code,
};
// 1}}}

// {{{1 "to" event
local genTo(t) = (
  local tsc = get(t, 'sc');  // to.shell_command
  local tk = get(t, 'k');  // to.key
  local tm = get(t, 'm');  // to.modifiers
  local ts = get(t, 's');  // setters(to.set_variable, to.notification_message)

  if ts != null then
    assert std.type(ts) == 'array' : |||
        manipulator: t.s(setters -> [to.set_variable, to.notification_message]) must be an array!
    |||;
    ts
  else {
    shell_command: if std.type(tsc) == 'string' then tsc,
    key_code: if self.shell_command == null then (if std.isString(t) then t else tk),
    modifiers: if self.shell_command == null then tm,
  }
);
// 1}}}

// {{{1 "to_delayed_action" event
local genTd(td) = {
  local tdi = get(td, 'i'),  // to_delayed_action.if_invoked
  local tdc = get(td, 'c'),  // to_delauyed_action.if_caceled

  to_if_invoked: if tdi != null then tdi,
  to_if_canceled: if tdc != null then tdc,
};
// 1}}}

local manipulator(o, desc='') = std.prune({
  local f = get(o, 'f'),  // from
  from: std.prune(genFrom(f)),

  local t = get(o, 't'),  // to
  to: std.prune(genTo(t)),

  local td = get(o, 'td'),  // to_delayed_action
  to_delayed_action: std.prune(genTd(td)),

  local c = get(o, 'c'),  // conditions
  assert c == null || std.type(c) == 'array' : 'manipulator: c(conditions) must be an array!',
  conditions: c,

  local p = get(o, 'p'),  // parameters
  parameters: p,

  type: 'basic',
  [if !std.isEmpty(desc) then 'description']: desc,
});

{
  call: manipulator,
}

// vim:fdm=marker:ai:
