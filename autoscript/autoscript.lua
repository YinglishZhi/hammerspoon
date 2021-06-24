
local cmdArray = {
    "cd /Users/moni/logs && source 111.sh"
}

function shell(cmd)
    result = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
end


function runAutoScripts()
    -- hs.alert.show("Hello World!")
    print("hello world")
    spoon.AClock:toggleShow();
end

hs.timer.doEvery(2, runAutoScripts)