local mod = require 'core/mods'

local state = {
  exegesis = "apes together strong",
  version_major = 0,
  version_minor = 0,
  version_patch = 1,
  last_script = nil
}





-- APE HOOKS

mod.hook.register("system_post_startup", "APETOOLS POST-STARTUP", function()
  print("APETOOLS POST-STARTUP")
end)

mod.hook.register("system_pre_shutdown", "APETOOLS PRE-SHUTDOWN", function()
  print("APETOOLS PRE-SHUTDOWN")
end)

mod.hook.register("script_pre_init", "APETOOLS PRE-INIT", function()
  print("APETOOLS PRE-INIT")
  state.last_script = norns.state.script
end)

mod.hook.register("script_post_cleanup", "APETOOLS POST-CLEANUP", function()
  print("APETOOLS POST-CLEANUP")
end)





-- APE TOOLS

function screenshot()
  _norns.screen_export_png("/home/we/dust/APETOOLS-screenshot-" .. os.time() .. ".png")
end

function rerun(safe)
  local script = (safe ~= nil) and norns.state.script or state.last_script
  if script ~= nil and script ~= "" then
    norns.script.load(script)
  else
    print("APETOOLS FOUND SCRIPT TO RELOAD!")
  end
end

function r(safe)
  rerun(safe)
end




-- NORNS SYSTEM MENU

local m = {}

m.key = function(n, z)
  if n == 2 and z == 1 then
    mod.menu.exit()
  end
end

m.enc = function(n, d)
  print("APETOOLS ENCS UNUSED", n, d)
  mod.menu.redraw()
end

m.redraw = function()
  screen.clear()
  screen.move(64,32)
  screen.text_center(state.exegesis)
  screen.move(64,40)
  screen.text_center("APETOOLS v" .. 
                    state.version_major .. "." ..
                    state.version_minor .. "." .. 
                    state.version_patch)
  screen.update()
end

m.init = function()
  print("APETOOLS LOOK AT YOU SHOWING YOUR FACE AROUND HERE")
end

m.deinit = function()
  print("APETOOLS KEEP THE CHANGE YA FILTHY ANIMAL")
end

mod.menu.register(mod.this_name, m)





-- Ape, Private Investigator

local api = {}

api.get_state = function()
  return state
end

return api