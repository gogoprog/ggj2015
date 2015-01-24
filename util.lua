Util = Util or {}

local mpi = math.pi

function Util:getDeltaAngle(a , b)
    local delta
    delta = b - a

    if delta > mpi then
        delta = delta - mpi * 2
    end

    if delta < - mpi then
        delta = delta + mpi * 2
    end

    return delta
end