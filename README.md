# ESX DRUGLABS
Author: https://forum.cfx.re/u/dividerz/summary

Support: https://discord.gg/WxZ83u3 - New Discord Server for support

# REQUIREMENTS / DEPENDENCIES
- es_extended (legacy) -> https://github.com/esx-framework/es_extended/tree/v1-final
- bob74_ipl -> https://github.com/Bob74/bob74_ipl
- progressBar -> https://github.com/EthanPeacock/progressBars/releases/tag/1.0

If you don't have any of these dependencies installed and started, the script will throw an error and will **not** start.

# USAGE AND INSTALLATION
Insert the .sql file in your database and move the images in 'INVENTORYHUD IMAGES' to your image directory of your inventory script.
Drag and drop this resource in your ESX folder and start it using ```ensure esx_druglabs``` in your server.cfg. Telporters can be changed by changing the 'enter' coords in the ```config.lua``` file, see example below.

```
    meth = {
        teleporters = {
            enter = vector3(1737.92, 3709.04, 34.14), --> YOU WANT TO CHANGE THIS FOR THE ENTER POINT
            exit = vector3(997.08, -3200.63, -36.39) --> DON'T TOUCH THIS ONE, THIS DEFINES THE SPAWN LOCATION INSIDE THE IPL
        },
        process = {
            filling = vector3(1002.25, -3198.89, -38.99),
            producing = vector3(1005.76, -3200.33, -38.52),
            producing2 = vector3(1014.65, -3198.09, -38.99),
            packaging = vector3(1016.46, -3194.92, -38.99),
            storage = vector3(1731.80, 3707.72, 34.12)
        }
        
    },
```

Last thing you should do is give someone a key / sell them somewhere, I don't know what else... 

**USAGE**

Players can enter each 'lab' when they have the needed key in their inventory. They can eventually produce drugs in these labs which they'll receive as an item in their inventory as end product.
