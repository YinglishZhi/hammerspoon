--- === AClock ===
---
--- Just another clock, floating above all
---
--- Download: [https://github.com/Hammerspoon/Spoons/raw/master/Spoons/AClock.spoon.zip](https://github.com/Hammerspoon/Spoons/raw/master/Spoons/AClock.spoon.zip)

local obj={}
obj.__index = obj

-- Metadata
obj.name = "AClock"
obj.version = "1.0"
obj.author = "ashfinal <ashfinal@gmail.com>"
obj.homepage = "https://github.com/Hammerspoon/Spoons"
obj.license = "MIT - https://opensource.org/licenses/MIT"

function obj:init()
    self.canvas = hs.canvas.new({x=0, y=0, w=0, h=0}):show()
    self.canvas[1] = {
        type = "text",
        text = "",
        textFont = "Impact",
        textSize = 130,
        textColor = {hex="#1891C3"},
        textAlignment = "center",
    }
end

--- AClock:toggleShow()
--- Method
--- Show AClock, if already showing, just hide it.
---

function obj:toggleShow()
    if self.timer then
        self.timer:stop()
        self.timer = nil
        self.canvas:hide()
    else
        local mainScreen = hs.screen.mainScreen()
        local mainRes = mainScreen:fullFrame()
        self.canvas:frame({
            x = (mainRes.w-900)/2,
            y = (mainRes.h-920)/2,
            w = 900,
            h = 920
        })
        local nowTime = os.time()
        local tb = {}
        tb.year = tonumber(os.date("%Y",nowTime))
        tb.month =tonumber(os.date("%m",nowTime))
        tb.day = tonumber(os.date("%d",nowTime))
        local goodByeTime = os.time({year=tb.year, month=tb.month, day=tb.day,hour=19, min=0, sec=0})
        local happyTime = goodByeTime-nowTime;

        local content
        if happyTime > 0 then
            local content1
            if happyTime > 3600 then
                content1 =string.format("%.0f", happyTime/3600).."个多小时"
            elseif happyTime > 60 then
                content1 =string.format("%.2f", happyTime/60).."分钟"
            else
                content1 =string.format("%.0f", happyTime).."秒！！！"
            end
        
            self.canvas[1].textColor = {hex="#215E21"}

            content = "\n".."距离下班还有"..
            "\n"..happyTime.."秒"..
            "\n".."约等于"..content1
        else
            happyTime = -happyTime;
            local time
            if happyTime > 3600-1 then
                self.canvas[1].textColor = {hex="#FF0000"}
                time =string.format("%.0f", happyTime/3600).."个多小时了".."\n".."求求你别卷了⚠️⚠️⚠️"
            elseif happyTime > 60-1 then
                self.canvas[1].textColor = {hex="#FFFF00"}
                time =string.format("%.0f", happyTime/60).."分钟了，赶紧走吧"
            else 
                time = happyTime.."秒了".."，溜了溜了"
            end
            content = "\n".."已经下班"..time
        end

        self.canvas[1].text = os.date("%H:%M:%S")..content
     
    
        self.canvas:show()
        self.timer = hs.timer.doAfter(4, function()
            self.canvas:hide()
            self.timer = nil
        end)
    end
end

return obj
