-- UIBase.lua
-- UI基类模块

-- 导入UI服务
-- 这使得我们可以从模块脚本里管理UI显示
local UIService = require(script.Parent.UIService)

local UIBase = {}

-- UI类型查找表
UIBase.UIType = {
    NORMAL = 1, -- 普通UI，可与其他UI共存
    POPUP = 2,  -- 弹出UI，会遮挡部分UI但不关闭其他UI
    FULLSCREEN = 3, -- 全屏UI，打开时关闭所有其他UI
}

-- UI基础类
UIBase.Base = {}
UIBase.Base.__index = UIBase.Base


-- 创建UI基础实例
function UIBase.Base.new(name, uiType, prefabPath)
    local self = setmetatable({}, UIBase.Base)
    self.name = name            -- UI名称
    self.uiType = uiType        -- UI类型
    self.prefabPath = prefabPath -- UI预制体路径
    self.isActive = false       -- 是否激活
    self.uiObject = nil         -- UI对象引用
    self.data = nil             -- UI数据
    return self
end

-- 初始化方法
function UIBase.Base:OnInit()
    -- 初始化UI逻辑，可由子类重写

end

-- 打开UI
function UIBase.Base:OnOpen(data)
    if not self.isActive then
        self.isActive = true
        self.data = data -- 存储传入的数据
        
        -- 处理数据显示逻辑
        self:OnHandleData(data)
        
        -- 实例化并显示UI
        local success, result = pcall(function()
            -- 根据环境获取不同的服务
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local prefabPath = self.prefabPath
            

            
            -- 检查ReplicatedStorage是否存在
            if not ReplicatedStorage then

                return nil
            end
            
            -- 检查ReplicatedStorage下的内容

            -- 检查ReplicatedStorage内容
            
            -- 分解路径字符串
            local pathParts = string.split(prefabPath, "/")
            local current = ReplicatedStorage
            
            -- 循环遍历路径部分以找到预制体
            for i = 2, #pathParts do -- 从2开始因为第一个是ReplicatedStorage
                if current:FindFirstChild(pathParts[i]) then
                    current = current:WaitForChild(pathParts[i])

                else

                    return nil
                end
            end
            
            -- 克隆并显示UI
            if current then
                -- 检查是否是有效的预制体
                if current:IsA("GuiObject") or current:IsA("ScreenGui") or current:IsA("Frame") then
                    self.uiObject = current:Clone()
                    
                    -- 不直接设置Parent，留给LocalScript处理
                    -- ModuleScript环境下不能直接访问PlayerGui
                    
                    -- 设置一些属性，确保可见
                    if self.uiObject:IsA("GuiObject") then
                        self.uiObject.Visible = true
                    end
                    
                    -- 确保所有子对象的可见性
                    for _, child in pairs(self.uiObject:GetDescendants()) do
                        if child:IsA("GuiObject") then
                            child.Visible = true
                        end
                    end
                    
                    -- 使用UIService显示UI
                    UIService:ShowUI(self.uiObject, self.name)

                    
                    -- 保存UI对象并返回
                    self.uiObject = self.uiObject
                    return self.uiObject
                else

                    return nil
                end
            else

                return nil
            end
        end)
        
        if not success then

        end
        

    end
end

-- 处理传入的数据
function UIBase.Base:OnHandleData(data)
    -- 默认什么都不做，由子类实现
    -- 当传入数据时可以重写此方法来处理数据
    if data then

    end
end

-- 关闭UI
function UIBase.Base:OnClose()
    -- 关闭UI逻辑，可由子类重写
    self.isActive = false
    self.data = nil -- 清除数据
    
    -- 如果有UI对象，隐藏它
    if self.uiObject then

        
        -- 使用UIService隐藏UI
        UIService:HideUI(self.name)
    end
    

end

-- 销毁UI
function UIBase.Base:OnDestroy()
    -- 销毁UI资源，可由子类重写
    if self.uiObject then
        -- 使用UIService销毁UI
        UIService:DestroyUI(self.name)
        self.uiObject = nil
    end
    self.data = nil

end

-- 设置为全局变量
_G.UIBase = UIBase

return UIBase
