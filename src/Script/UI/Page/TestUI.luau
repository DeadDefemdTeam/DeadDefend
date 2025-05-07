-- 游戏菜单界面
local TestUI = {}

-- 创建MenuUI
function TestUI.new()
    -- 直接返回接口对象，不使用元表
    return TestUI
end

-- 初始化方法
function TestUI:OnInit()

    
end

-- 打开UI并处理数据
function TestUI:OnOpen(data)

    
end

-- 处理传入的数据
function TestUI:OnHandleData(data)
    -- 这里可以根据传入的数据更新UI显示
    if not data then return end
    
end

-- 关闭UI
function TestUI:OnClose()

    
end

-- 销毁UI
function TestUI:OnDestroy()


end

return TestUI
