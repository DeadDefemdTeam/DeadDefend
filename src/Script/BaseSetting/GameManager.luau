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
    
    -- 打开菜单UI
    GameManager.OpenMenuUI()
end

-- 打开菜单UI的方法
function GameManager.OpenMenuUI()
    print("GameManager: 尝试打开MenuUI...")

    
    -- 传递数据打开菜单UI
    _G.UIManager:OpenWindow(_G.UIDefine.MenuUI, {
        playerName = "Player1",
        level = 10,
        gold = 1000,
        isNewGame = true
    })
end

_G.GameManager = GameManager

return GameManager