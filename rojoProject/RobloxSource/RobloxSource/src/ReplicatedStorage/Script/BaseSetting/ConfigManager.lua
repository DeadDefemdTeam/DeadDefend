--[[
    配置管理器 (简化版)
    使用方法: 
    1. 先调用ConfigManager.Init()初始化
    2. 然后通过configmanager.enemy[id]直接访问敌人数据
]]

-- 在Roblox中，正确引用其他目录的模块
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TableData = require(ReplicatedStorage.Script.OutputCfg.TableData)

-- 定义配置管理器
local ConfigManager = {}

-- 初始化方法
function ConfigManager.Init()
    -- 为每个TableData中的表格创建直接访问属性
    for tableName, tableData in pairs(TableData) do
        ConfigManager[string.lower(tableName)] = tableData
    end
    ConfigManager.initialized = true
end

_G.ConfigManager = ConfigManager

return ConfigManager
