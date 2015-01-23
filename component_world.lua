ComponentWorld = {}


function ComponentWorld:init()
end

function ComponentWorld:insert()
end

function ComponentWorld:update(dt)
    local mouse = gengine.input.mouse

    if mouse:isJustPressed(1) then
        local x,y = gengine.input.mouse:getPosition()

    end
end

function ComponentWorld:remove()
end