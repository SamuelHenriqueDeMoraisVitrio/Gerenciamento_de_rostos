

---@class ImageMgkResponse

---@class ImageMgk
---@field image_formated fun(any):ImageMgkResponse
---@field convert_to_jpeg fun(any):ImageMgkResponse


local load_lua = package.loadlib("dependencies/imageMagick/imageMGK.so", "luaopen_my_lib")

---@type ImageMgk
local lib = load_lua()

return lib



