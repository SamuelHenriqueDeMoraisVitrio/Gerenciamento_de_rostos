

---@class ExtractResponse

---@class Extract
---@field extract fun(any):ExtractResponse
---@field compar fun(metrics_1:string, metrics_2:string):ExtractResponse

local load_lua = package.loadlib("dependencies/dlib_face_detection/extract.so", "extract_face_main")

---@type Extract
local lib = load_lua()

return lib



