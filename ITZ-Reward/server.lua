ESX = exports["es_extended"]:getSharedObject()

-- Variable para controlar si el comando está habilitado
local welcomePackEnabled = true

-- Comando para dar el pack de bienvenida
RegisterCommand('welcomepack', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier

    -- Verifica si el comando está deshabilitado
    if not welcomePackEnabled then
        TriggerClientEvent('esx:showNotification', source, 'El pack de bienvenida está deshabilitado.')
        return
    end

    -- Verifica si el jugador ya ha reclamado su pack de bienvenida desde la nueva tabla
    MySQL.Async.fetchAll('SELECT hasClaimed FROM welcome_packs_claimed WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    }, function(result)

        -- Verifica si el resultado contiene datos
        if result[1] and result[1].hasClaimed then
            TriggerClientEvent('esx:showNotification', source, 'Ya has reclamado tu pack de bienvenida.')
        else
            -- Si no existe el registro, crea uno y marca al jugador como que ya ha reclamado su pack
            MySQL.Async.execute('INSERT INTO welcome_packs_claimed (identifier, hasClaimed) VALUES (@identifier, 1)', {
                ['@identifier'] = identifier
            })
            
            -- Da 2 aguas
            xPlayer.addInventoryItem('water', 2)

            -- Da 2 aguas
            xPlayer.addInventoryItem('burger', 3)

            -- Da 2 aguas
            xPlayer.addInventoryItem('phone', 1)
            
            -- Da 20,000 de dinero
            xPlayer.addMoney(20000)

            -- Notificación de éxito
            TriggerClientEvent('esx:showNotification', source, 'Has reclamado tu pack de bienvenida.')
        end
    end)
end)

-- Comando para activar el welcomepack
RegisterCommand('actrecompensa', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)

    -- Comprueba si el jugador es administrador (esto depende de cómo se manejen los permisos en tu servidor)
    if xPlayer.getGroup() == 'admin' then
        welcomePackEnabled = true
        TriggerClientEvent('esx:showNotification', source, 'El pack de bienvenida ha sido activado.')
    else
        TriggerClientEvent('esx:showNotification', source, 'No tienes permisos para usar este comando.')
    end
end, false)

-- Comando para desactivar el welcomepack
RegisterCommand('desactrecompensa', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)

    -- Comprueba si el jugador es administrador
    if xPlayer.getGroup() == 'admin' then
        welcomePackEnabled = false
        TriggerClientEvent('esx:showNotification', source, 'El pack de bienvenida ha sido desactivado.')
    else
        TriggerClientEvent('esx:showNotification', source, 'No tienes permisos para usar este comando.')
    end
end, false)