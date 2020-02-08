
local cmdArray = {
    "cd /Users/moni/logs && source 111.sh"
}

function shell(cmd)
    result = hs.osascript.applescript(string.format('do shell script "%s"', cmd))
end


function runAutoScripts()
    hs.alert.show("Hello World!")
    for key, cmd in ipairs(cmdArray) do
        shell(cmd)
    end
end

hs.timer.doEvery(3600, runAutoScripts)