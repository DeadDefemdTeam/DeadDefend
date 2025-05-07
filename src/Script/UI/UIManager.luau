-- UIManager.lua
-- UI管理器，负责管理所有UI界面

local UIDefineModule = require(script.Parent.UIDefine)
local UIBaseModule = require(script.Parent.UIBase)

local UIManager = {}

-- 初始化函数
function UIManager:Init()
    self.uiDict = {}      -- 存储所有已创建的UI实例的字典 {名称: UI实例}
    self.uiStack = {}     -- UI栈，用于跟踪当前打开的UI
    self.activeUICount = 0 -- 当前激活的UI数量
end

-- 尝试加载UI类
function UIManager:TryLoadUIClass(uiName)
    -- 检查是否存在对应的UI类
    local success, uiClass = pcall(function()
        -- 尝试从 Page 文件夹中加载类
        return require(script.Parent.Page[uiName])
    end)
    
    if success and uiClass then

        
        return uiClass
    else

        return nil
    end
end

-- 创建UI实例
function UIManager:CreateUIInstance(uiDefine)
    if not uiDefine then return nil end
    
    -- 如果已经创建过这个UI实例，直接返回
    if self.uiDict[uiDefine.name] then
        return self.uiDict[uiDefine.name]
    end
    
    -- 尝试加载特定UI类
    local uiClass = self:TryLoadUIClass(uiDefine.name)
    
    local newUI
    if uiClass then
        -- 使用特定UI类创建实例
        newUI = uiClass.new()
        -- 设置基本属性
        newUI.name = uiDefine.name
        newUI.uiType = uiDefine.type
        newUI.prefabPath = uiDefine.prefabPath
        newUI.isActive = false
        newUI.uiObject = nil
        newUI.data = nil
    else
        -- 使用基础UI类创建实例
        newUI = UIBaseModule.Base.new(uiDefine.name, uiDefine.type, uiDefine.prefabPath)
    end
    
    -- 存储实例
    self.uiDict[uiDefine.name] = newUI
    
    -- 先调用父类的OnInit方法，再调用子类的方法
    if UIBaseModule.Base.OnInit then
        print("调用父类OnInit方法: " .. newUI.name)
        UIBaseModule.Base.OnInit(newUI)
    end
    
    -- 然后调用子类的OnInit方法
    newUI:OnInit()
    
    return newUI
end

-- 检查UI是否在栈中
function UIManager:IsUIInStack(uiDefine)
    if not uiDefine then return false end
    
    for _, ui in ipairs(self.uiStack) do
        if ui.name == uiDefine.name then
            return true
        end
    end
    
    return false
end

-- 打开窗口
function UIManager:OpenWindow(uiDefine, data)
    if not uiDefine then
        print("错误：尝试打开未定义的UI")
        return false
    end
    
    -- 创建或获取UI实例
    local ui = self:CreateUIInstance(uiDefine)
    
    -- 如果UI已经在栈中并活跃，则只简单刷新数据
    if self:IsUIInStack(uiDefine) and ui.isActive then
        ui.data = data -- 更新数据
        ui:OnHandleData(data) -- 处理新数据
        print("更新UI数据: " .. uiDefine.name)
        return true
    end
    
    -- 根据UI类型处理栈关系
    if uiDefine.type == UIBaseModule.UIType.FULLSCREEN then
        -- 全屏UI：关闭其他所有UI
        self:CloseAllUI()
    end
    
    -- 将UI加入栈中
    table.insert(self.uiStack, ui)
    self.activeUICount = self.activeUICount + 1
    
    local uiObject = nil
    if UIBaseModule.Base.OnOpen then
        print("调用父类OnOpen方法: " .. uiDefine.name .. " (数据信息为: " .. tostring(data) .. ")")
        uiObject = UIBaseModule.Base.OnOpen(ui, data)
    end
    
    ui:OnOpen(data)
    
    return true
end

-- 关闭窗口
function UIManager:CloseWindow(uiDefine)
    if not uiDefine then
        print("错误：尝试关闭未定义的UI")
        return false
    end
    
    -- 获取UI实例
    local ui = self.uiDict[uiDefine.name]
    
    -- 如果UI不存在或未激活，直接返回
    if not ui or not ui.isActive then
        return false
    end
    
    -- 从栈中移除
    for i = #self.uiStack, 1, -1 do
        if self.uiStack[i].name == uiDefine.name then
            table.remove(self.uiStack, i)
            break
        end
    end


    self.activeUICount = self.activeUICount - 1
    
    -- 先调用父类的OnClose方法
    if UIBaseModule.Base.OnClose then

        UIBaseModule.Base.OnClose(ui)
    end
    
    -- 然后调用子类的OnClose方法
    ui:OnClose()
    

    
    -- 添加销毁UI的逻辑
    if UIBaseModule.Base.OnDestroy then

        UIBaseModule.Base.OnDestroy(ui)
    end
    
    -- 调用子类的OnDestroy方法
    ui:OnDestroy()
    
    -- 从UI字典中移除
    self.uiDict[uiDefine.name] = nil
    

    return true
end

-- 关闭栈顶UI
function UIManager:CloseTopUI()
    if #self.uiStack > 0 then
        local ui = self.uiStack[#self.uiStack]
        -- 先找到对应的UIDefine
        for name, uiDefine in pairs(UIDefineModule) do
            if uiDefine and type(uiDefine) == "table" and uiDefine.name == ui.name then
                return self:CloseWindow(uiDefine)
            end
        end
    end
    
    return false
end

-- 关闭所有UI
function UIManager:CloseAllUI()
    -- 从栈顶到栈底依次关闭UI
    for i = #self.uiStack, 1, -1 do
        local ui = self.uiStack[i]
        ui:OnClose()
    end
    
    -- 清空栈
    self.uiStack = {}
    self.activeUICount = 0
end

-- 获取当前栈顶UI
function UIManager:GetTopUI()
    if #self.uiStack > 0 then
        return self.uiStack[#self.uiStack]
    end
    
    return nil
end

-- 获取当前UI栈
function UIManager:GetUIStack()
    return self.uiStack
end

-- 检查UI是否激活
function UIManager:IsUIActive(uiDefine)
    if not uiDefine then return false end
    
    local ui = self.uiDict[uiDefine.name]
    return ui and ui.isActive
end

-- 根据名称检查UI是否激活
function UIManager:IsUIActiveByName(name)
    for _, ui in ipairs(self.uiStack) do
        if ui.name == name then
            return true
        end
    end
    
    return false
end

-- 获取激活的UI数量
function UIManager:GetActiveUICount()
    return self.activeUICount
end

-- 销毁所有UI
function UIManager:DestroyAllUI()
    for name, ui in pairs(self.uiDict) do
        ui:OnDestroy()
    end
    
    self.uiDict = {}
    self.uiStack = {}
    self.activeUICount = 0
end

-- 设置为全局变量
---@class UIManager
_G.UIManager = UIManager

return UIManager
