BaseConverter = {}
BaseConverter.__index = BaseConverter

function BaseConverter:create(decimal,hexnum,bin)
  local base = {}
  setmetatable(base,BaseConverter)

  base.DecNumber = decimal or 0
  base.HexNumber = 0
  base.Binary = bin
  base.BinTable = {}
  base.HexString = hexnum or 0
  base.HexTable = {}

  local function swap(tbl,m,n)
    temp = tbl[m]
    tbl[m] = tbl[n]
    tbl[n] = temp
  end

-- Hex Conversion --------------------------
  if base.DecNumber == 0 then
    base.HexNumber = 0
  end

  if base.HexNumber == nil then
    tbl = {}
    dec = base.DecNumber
    while dec ~= 0 do
      table.insert(tbl, dec % 16)
      dec = dec // 16
    end

    for i = 1, #tbl // 2 do
      swap(tbl,i,#tbl - i + 1)
    end
    base.HexNumber = table.concat(tbl)
  end
---------------------------------------------

----- Binary Conversion ---------------------
if base.DecNumber == 0 then
  base.Binary = 0
end

if base.Binary == nil then
  tbl = {}
  dec = base.DecNumber
  while dec ~= 0 do
    table.insert(tbl, dec % 2)
    dec = dec // 2
  end
  while #tbl % 4 ~= 0 do
    table.insert(tbl,0)
  end

  for i = 1, #tbl // 2 do
    swap(tbl,i,#tbl - i + 1)
  end
  base.BinTable = tbl
  base.Binary = table.concat(tbl)
end
---------------------------------------------
--[[
 - Hex Conversion to Hex digits -
 - this uses the binary values in groups of 4 to find the Hex digit associated -
  ]]--
-------------------------------------------------
  local hex = 0
  local exp = 3
  --table.insert(base.HexTable,"0x")
  for k,v in pairs(base.BinTable) do
    hex = math.floor(hex + (v * 2^(exp)))
    exp = exp - 1
    if k % 4 == 0 then
      exp = 3
      if hex < 10 then table.insert(base.HexTable,hex)
      elseif hex == 10 then table.insert(base.HexTable,"A")
      elseif hex == 11 then table.insert(base.HexTable,"B")
      elseif hex == 12 then table.insert(base.HexTable,"C")
      elseif hex == 13 then table.insert(base.HexTable,"D")
      elseif hex == 14 then table.insert(base.HexTable,"E")
      elseif hex == 15 then table.insert(base.HexTable,"F")
      end
      hex = 0
    end
  end

base.HexString = table.concat(base.HexTable)
-------------------------------------------------
  return base
end

function BaseConverter:convertToHex()
  -- Hex Conversion --------------------------
    if self.DecNumber == 0 then
      self.HexNumber = 0
    end
    local tbl = {}
    dec = self.DecNumber
    while dec ~= 0 do
      table.insert(tbl, dec % 16)
      dec = dec // 16
    end
    for i = 1, #tbl // 2 do
      swap(tbl,i,#tbl - i + 1)
    end
    self.HexNumber = table.concat(tbl)
  end
  ---------------------------------------------
