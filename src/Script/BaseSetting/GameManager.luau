-- GameManager.lua

local GameManager = {}

-- 初始化函数
function GameManager.Init()
    print("GameManager初始化中...")
    
    
    -- 使用ConfigManager的例子
    -- 获取敌人数据
    local enemyData = _G.ConfigManager.enemy["1"] -- 也可以直接用数字: configmanager.enemy[1]
    if enemyData then
        print("加载敌人数据: " .. enemyData.Name .. ", HP: " .. enemyData.MaxHP)
    end
    
end

_G.GameManager = GameManager

return GameManager