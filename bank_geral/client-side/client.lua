-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
client= {}
Tunnel.bindInterface(GetCurrentResourceName(),client)
vSERVER = Tunnel.getInterface(GetCurrentResourceName())

local cds = {
    [1] = {['x'] = -1152.3453369141, ['y'] = 58.153991699219, ['z'] = 55.310695648193 }
}

Citizen.CreateThread(function()
    while true do
        local time = 1000
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped) 

        for k,v in pairs(cds) do 
            
            local distance = #(coords - vector3(v.x,v.y,v.z))
            if distance < 10 then

                DrawMarker(29,v.x,v.y,v.z,0,0,0,0,0,0,1.00,1.00,1.00,255,0,0,100,0,0,0,1)

                if distance < 2 then
                    if IsControlJustPressed(1,38) then

                        local infos = vSERVER.getInfos() 

                        SendNUIMessage({ 
                            open = true,
                            saldo = infos.bank,
                            nome_completo = infos.name.." "..infos.name2,
                            id_User = infos.id,
                            salarios = vSERVER.getSalarios() 
                        })
                        
                        SetNuiFocus(true,true)

                    end
                end

                time = 1
            end

        end
        
        
        Wait(time)
    end
end)


RegisterNUICallback('fechar', function(data, cb)
    SetNuiFocus(false,false)
end)

RegisterNUICallback('depositar', function(data, cb)
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
    print(data.valor)
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")

    local retorno = vSERVER.depositar(data.valor)
    cb({ status = retorno })

end)

RegisterNUICallback('sacar', function(data, cb)
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
    print(data.valor)
    print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")

    local retorno = vSERVER.sacar(data.valor)
    cb({ status = retorno })
end)

RegisterNUICallback('receberSalario', function(data, cb)
    local retorno = vSERVER.delSalarios(data.id, data.price)
    cb({ status = retorno, salarios = vSERVER.getSalarios() })
end)


