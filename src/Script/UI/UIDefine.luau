-- UIDefine.lua
-- UI定义模块，定义具体的UI窗口

local UIBaseModule = require(script.Parent.UIBase) -- 先加载UIBase模块

local UIDefine = {}

-- 定义具体的UI窗口

-- 全屏UI

-- 菜单UI
UIDefine.MenuUI = {
    name = "MenuUI",
    type = UIBaseModule.UIType.FULLSCREEN,
    prefabPath = "ReplicatedStorage/UIPrefab/MenuUI",
}

UIDefine.TestUI = {
    name = "TestUI",
    type = UIBaseModule.UIType.FULLSCREEN,
    prefabPath = "ReplicatedStorage/UIPrefab/TestUI",
}

-- 页面UI


-- 弹窗UI

-- 设置为全局变量
_G.UIDefine = UIDefine

return UIDefine
