#!/usr/bin/lua
local lanes = require("lanes").configure()
local posix = require("posix")
local lfs = require("lfs")

local function read_photos(dir)
  local photos = {}

  for photo in lfs.dir(dir) do
    if string.match(photo, "%.jpg$") or
      string.match(photo, "%.png$") or
      string.match(photo, "%.svg$")
    then
      table.insert(photos, dir .. photo)
    end
  end
  return photos
end

local function get_photo(photos)
  local i = math.random(1, #photos)
  return table.remove(photos, i)
end

local function change_wallpaper(photo)
  os.execute('pkill swaybg')
  os.execute("swaybg -i " .. photo .. " -m fill")
end

local function main()
  if #arg < 2 then
    print('Usage: lua autopaper.lua [wallpaper_directory] [time between wallpaper change]')
    os.exit()
  end

  local dir = arg[1]
  local sleep = tonumber(arg[2])

  local photos = read_photos(dir)
  while true do
    local photo = get_photo(photos)

    lanes.gen("*", change_wallpaper)(photo)

    if #photos == 0 then
      photos = read_photos(dir)
    end

    posix.sleep(sleep)
  end

end
main()
