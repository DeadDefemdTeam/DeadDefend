-- 游戏菜单界面
local MenuUI = {}

-- 创建MenuUI
function MenuUI.new()
    -- 直接返回接口对象，不使用元表
    return MenuUI
end

-- 初始化方法
function MenuUI:OnInit()

    
    -- 初始化中不设置按钮事件，因为此时UI对象还未创建
end

-- 打开UI并处理数据
function MenuUI:OnOpen(data)
    -- -- 设置按钮事件，在OnOpen方法中执行，因为此时UI对象已经创建
    local btnOpen = self.uiObject.Open
    if btnOpen then
        btnOpen.MouseButton1Click:Connect(function()
            -- 在这里调用打开TestUI的代码
            _G.UIManager:OpenWindow(_G.UIDefine.TestUI)
        end)
    end

    local btnClose = self.uiObject.Close
    if btnClose then
        btnClose.MouseButton1Click:Connect(function()
            -- 在这里调用打开TestUI的代码
            _G.UIManager:CloseWindow(_G.UIDefine.TestUI)
        end)
    end
end

-- 处理传入的数据
function MenuUI:OnHandleData(data)
    -- 这里可以根据传入的数据更新UI显示
    if not data then return end
    
end

-- 关闭UI
function MenuUI:OnClose()

    
end

-- 销毁UI
function MenuUI:OnDestroy()

end



return MenuUI
