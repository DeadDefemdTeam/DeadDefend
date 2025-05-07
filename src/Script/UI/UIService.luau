-- UIService.lua
-- UI服务模块，统一管理UI的显示、隐藏和销毁
-- 这是一个ModuleScript，可以被其他ModuleScript引用，但界面处理会推迟到LocalScript执行

local UIService = {
    _uiObjects = {}, -- 保存所有UI对象 {uiName = uiObject}
    _pendingActions = {}, -- 等待执行的UI操作
    _initialized = false,
    _localScriptHandler = nil -- 由LocalScript设置的处理函数
}

-- 注册LocalScript处理器
function UIService:RegisterLocalScriptHandler(handler)
    self._localScriptHandler = handler
    self._initialized = true
    
    -- 执行所有挂起的操作
    for _, action in ipairs(self._pendingActions) do
        if action.type == "show" then
            self:_processShowUI(action.uiObject, action.uiName)
        elseif action.type == "hide" then
            self:_processHideUI(action.uiName)
        elseif action.type == "destroy" then
            self:_processDestroyUI(action.uiName)
        end
    end
    
    -- 清空挂起的操作
    self._pendingActions = {}
    

    return true
end

-- 显示UI（内部）
function UIService:_processShowUI(uiObject, uiName)
    if self._localScriptHandler then
        self._uiObjects[uiName] = uiObject
        self._localScriptHandler.ShowUI(uiObject, uiName)
        return true
    end
    return false
end

-- 隐藏UI（内部）
function UIService:_processHideUI(uiName)
    if self._localScriptHandler and self._uiObjects[uiName] then
        self._localScriptHandler.HideUI(self._uiObjects[uiName], uiName)
        return true
    end
    return false
end

-- 销毁UI（内部）
function UIService:_processDestroyUI(uiName)
    if self._localScriptHandler and self._uiObjects[uiName] then
        self._localScriptHandler.DestroyUI(self._uiObjects[uiName], uiName)
        self._uiObjects[uiName] = nil
        return true
    end
    return false
end

-- 显示UI（公共接口）
function UIService:ShowUI(uiObject, uiName)
    if not uiObject then

        return false
    end
    
    -- 给UI对象定一个名称
    uiObject.Name = uiName
    
    if self._initialized and self._localScriptHandler then
        return self:_processShowUI(uiObject, uiName)
    else

        table.insert(self._pendingActions, {
            type = "show",
            uiObject = uiObject,
            uiName = uiName
        })
        return true
    end
end

-- 隐藏UI（公共接口）
function UIService:HideUI(uiName)
    if self._initialized and self._localScriptHandler then
        return self:_processHideUI(uiName)
    else

        table.insert(self._pendingActions, {
            type = "hide",
            uiName = uiName
        })
        return true
    end
end

-- 销毁UI（公共接口）
function UIService:DestroyUI(uiName)
    if self._initialized and self._localScriptHandler then
        return self:_processDestroyUI(uiName)
    else

        table.insert(self._pendingActions, {
            type = "destroy",
            uiName = uiName
        })
        return true
    end
end

-- 获取已注册的UI对象
function UIService:GetUIObject(uiName)
    return self._uiObjects[uiName]
end

-- 列出所有UI
function UIService:ListAllUI()
    local names = {}
    for name, _ in pairs(self._uiObjects) do
        table.insert(names, name)
    end
    return names
end

-- 检查服务是否初始化
function UIService:IsInitialized()
    return self._initialized
end

return UIService
