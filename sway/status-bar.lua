#!/usr/bin/lua
local lfs = require("lfs")

local function is_laptop()
  for file in lfs.dir('/sys/class/power_supply') do
    if file ~= '.' and file ~= ".." then
      return true
    end
  end

  return false
end

local function get_date()
  return os.date("%a %b %e, %H:%M:%S")
end

local function get_volume()
  local handle = io.popen('pactl get-sink-volume @DEFAULT_SINK@', "r")
  if not handle then return "0%" end

  local sink = string.match(handle:read("*a"), "%d+%%")
  handle:close()

  return "Volume: " .. string.match(sink, "%d+%%")
end

local function get_brightness()
  local handle = io.popen('brightnessctl | grep "Current"')
  if not handle then return "0%" end

  local brigtness = string.match(handle:read("*a"), "%d+%%")
  handle:close()

  return "Brightness: " .. brigtness
end

local function get_battery()
  local cap_file = io.open('/sys/class/power_supply/BAT0/capacity')
  local status_file = io.open('/sys/class/power_supply/BAT0/status')
  if not cap_file or not status_file then
    return 'Battery: Error'
  end

  local capacity = cap_file:read("*l") .. "%"
  local status = status_file:read("*l")
  if status ~= 'Discharging' then
    return status .. ": " .. capacity
  end

  cap_file:close()
  status_file:close()

  return 'Battery: ' .. capacity
end

local function get_desktop_status()
  return get_date() .. " | " .. get_volume() .. " | "
end

local function get_laptop_status()
  return get_desktop_status() .. get_brightness() .. " | " .. get_battery() .. " | "
end

local function main()
  local get_status

  if is_laptop() then
    get_status = get_laptop_status
  else
    get_status = get_desktop_status
  end

  while true do
    print(get_status())
    os.execute('sleep 0.1')
  end
end
main()

