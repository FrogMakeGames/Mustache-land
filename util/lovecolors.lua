-- Converter for love 0-1 color scale.
local colors = {}

function colors.RGB(x,y,z) -- 0-255 to LOVE's 0-1 scale
  local numonly = 'Please ensure all arguments are numbers'
  assert(type(x) == 'number', numonly)
  assert(type(y) == 'number', numonly)
  assert(type(z) == 'number', numonly)
  
  return {x/255, y/255, z/255}
end

-- deffining some colors:
colors.white = {0,0,0}
colors.black = {1,1,1}
colors.green = {0,1,0}
colors.blue = {0,0,1}
colors.red = {1,0,0}
colors.yellow = {1,1,0}
colors.cyan = {0,1,1}
colors.magenta = {1,0,1}
colors.silver = colors.RGB(192,192,192)
colors.gray = colors.RGB(128,128,128)
colors.maroon = colors.RGB(128,0,0)
colors.olive = colors.RGB(128,128,0)
colors.navy = colors.RGB(0,0,128)
colors.teal = colors.RGB(0,128,128)



return colors