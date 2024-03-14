-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cnServer = {}
Tunnel.bindInterface(GetCurrentResourceName(), cnServer)
vCLIENT = Tunnel.getInterface(GetCurrentResourceName())


function cnServer.getInfos() 
    
    local source = source
    local user_id = vRP.getUserId(source)

    return vRP.getInformation(user_id)[1]

    -- local obj = { 
    --     user_id = user_id,
    --     valor_banco = 0,
    --     nome = ""
    -- }

    -- if #info > 0 then 
    --     obj = {
    --         user_id = user_id,
    --         valor_banco = info[1].bank, -- banco
    --         nome = info[1].name.." "..info[1].name2 -- nome_completo
    --     }
    -- end

    -- return obj
end

function cnServer.depositar(valor) 
    
    local source = source
    local user_id = vRP.getUserId(source)

    local nome_item = "dollars"

    if vRP.tryGetInventoryItem(user_id,nome_item,parseInt(valor),true) then 
        vRP.addBank(user_id,parseInt(valor))
        return true
    else
        TriggerClientEvent("Notify",source,"vermelho","Dinheiro insuficiente na mochila.",5000)
        return false
    end
end

function cnServer.sacar(valor) 
    
    local source = source
    local user_id = vRP.getUserId(source)

    local nome_item = "dollars"

    if vRP.tryWithdraw(user_id,parseInt(valor)) then 
        return true
    else
        TriggerClientEvent("Notify",source,"vermelho","Dinheiro insuficiente no Banco.",5000)
        return false
    end
end

function cnServer.getSalarios() 
    local source = source
    local user_id = vRP.getUserId(source)

    return vRP.query("vRP/get_salary", { user_id = user_id})
end

function cnServer.delSalarios(id_salario, valor) 
    local source = source
    local user_id = vRP.getUserId(source)

    vRP.execute("vRP/del_salary", { id = id_salario,  user_id = user_id})
    vRP.addBank(user_id, parseInt(valor))
    TriggerClientEvent("Notify",source,"dinheiro","Salário recebido!",5000)
    return true
end


-- vRP.prepare("vRP/get_salary","SELECT * FROM vrp_salary WHERE user_id = @user_id")
-- vRP.prepare("vRP/del_salary","DELETE FROM vrp_salary WHERE id = @id AND user_id = @user_id")

