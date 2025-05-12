![brave_7Xjc7tTdGu](https://github.com/user-attachments/assets/75463fc1-5107-4ccf-aa43-76b72f51c4d7)

## qbx-signrobbery
A script that give you the ability to steal signs, hold them and trade them for materials all over the map.

## Dependencies:

* ox_inventory - https://github.com/overextended/ox_inventory
* scully_emotemenu - https://github.com/Scullyy/scully_emotemenu

## How to Install

### Step 1:

Drag qbx_signrobbery from your downloads folder to your [qbx] folder make sure you remove the _main so the resource is name qbx_singrobbery and not qbx_signrobbery_main

### Step 2:

Open qbx_signrobbery and in the images folder drag and drop them from there into ox_inventory/web/images

### Step 3:

Open your ox_inventory/data/items.lua and insert these items
```lua
    ['stopsign'] = {
        label = 'Stop Sign',
        weight = 1000,
        stack = true,
        close = true,
        client = {
            export = 'qbx_signrobbery.useStopSign',
        }
    },

    ['pedestriansign'] = {
        label = 'Pedestrian Sign',
        weight = 1000,
        stack = true,
        close = true,
        client = {
            export = 'qbx_signrobbery.usePedestrianSign',
        }
    },

    ['intersectionsign'] = {
        label = 'Intersection Sign',
        weight = 1000,
        stack = true,
        close = true,
        client = {
            export = 'qbx_signrobbery.useIntersectionSign',
        }
    },

    ['uturnsign'] = {
        label = 'U-Turn Sign',
        weight = 1000,
        stack = true,
        close = true,
        client = {
            export = 'qbx_signrobbery.useUTurnSign',
        }
    },

    ['noparkingsign'] = {
        label = 'No Parking Sign',
        weight = 1000,
        stack = true,
        close = true,
        client = {
            export = 'qbx_signrobbery.useNoParkingSign',
        }
    },

    ['leftturnsign'] = {
        label = 'Left Turn Sign',
        weight = 1000,
        stack = true,
        close = true,
        client = {
            export = 'qbx_signrobbery.useLeftTurnSign',
        }
    },

    ['rightturnsign'] = {
        label = 'Right Turn Sign',
        weight = 1000,
        stack = true,
        close = true,
        client = {
            export = 'qbx_signrobbery.useRightTurnSign',
        }
    },

    ['notrespassingsign'] = {
        label = 'No Trespassing Sign',
        weight = 1000,
        stack = true,
        close = true,
        client = {
            export = 'qbx_signrobbery.useNoTrespassingSign',
        }
    },

    ['yieldsign'] = {
        label = 'Yield Sign',
        weight = 1000,
        stack = true,
        close = true,
        client = {
            export = 'qbx_signrobbery.useYieldSign',
        }
    },

    ['boltcutter'] = {
        label = 'Bolt Cutter',
        weight = 2000,
        stack = false,
        close = false,
    },
```

### Step 4

In scully_emotemenu go to shared/data/emotes then insert these emotes
```lua
 {
            Label = 'Steal Intersection Sign ',
            Command = 'ssign13',
            Animation = 'base_club_shoulder',
            Dictionary = 'rcmnigel1d',
            Options = {
                Flags = {
                    Loop = true,
                    Move = true,
                },
                Props = {
                    {
                        Bone = 60309,
                        Name = 'prop_sign_road_03e',
                        Placement = {
                            vec3(-0.139, -0.987, 0.43),
                            vec3(-67.331528, 145.062790, -4.431889),
                        },
                    },
                },
            },
        },
        {
            Label = 'Steal UTurn Sign ',
            Command = 'ssign14',
            Animation = 'base_club_shoulder',
            Dictionary = 'rcmnigel1d',
            Options = {
                Flags = {
                    Loop = true,
                    Move = true,
                },
                Props = {
                    {
                        Bone = 60309,
                        Name = 'prop_sign_road_03m',
                        Placement = {
                            vec3(-0.139, -0.987, 0.43),
                            vec3(-67.331528, 145.062790, -4.431889),
                        },
                    },
                },
            },
        },
        {
            Label = 'Steal Parking Sign ',
            Command = 'ssign15',
            Animation = 'base_club_shoulder',
            Dictionary = 'rcmnigel1d',
            Options = {
                Flags = {
                    Loop = true,
                    Move = true,
                },
                Props = {
                    {
                        Bone = 60309,
                        Name = 'prop_sign_road_03n',
                        Placement = {
                            vec3(-0.139, -0.987, 0.43),
                            vec3(-67.331528, 145.062790, -4.431889),
                        },
                    },
                },
            },
        },
        {
            Label = 'Steal Left Turn Sign ',
            Command = 'ssign16',
            Animation = 'base_club_shoulder',
            Dictionary = 'rcmnigel1d',
            Options = {
                Flags = {
                    Loop = true,
                    Move = true,
                },
                Props = {
                    {
                        Bone = 60309,
                        Name = 'prop_sign_road_05e',
                        Placement = {
                            vec3(-0.139, -0.987, 0.43),
                            vec3(-67.331528, 145.062790, -4.431889),
                        },
                    },
                },
            },
        },
        {
            Label = 'Steal Right Turn Sign ',
            Command = 'ssign17',
            Animation = 'base_club_shoulder',
            Dictionary = 'rcmnigel1d',
            Options = {
                Flags = {
                    Loop = true,
                    Move = true,
                },
                Props = {
                    {
                        Bone = 60309,
                        Name = 'prop_sign_road_05f',
                        Placement = {
                            vec3(-0.139, -0.987, 0.43),
                            vec3(-67.331528, 145.062790, -4.431889),
                        },
                    },
                },
            },
        },
        {
            Label = 'Steal No Tresspassing Sign ',
            Command = 'ssign18',
            Animation = 'base_club_shoulder',
            Dictionary = 'rcmnigel1d',
            Options = {
                Flags = {
                    Loop = true,
                    Move = true,
                },
                Props = {
                    {
                        Bone = 60309,
                        Name = 'prop_sign_road_restriction_10',
                        Placement = {
                            vec3(0., -0.06, 0.1),
                            vec3(-67.331528, 145.062790, -4.431889),
                        },
                    },
                },
            },
        },
```

# Features

* Steal signs from around the map
* Hold signs / using them as an emote
* Trading the signs in for materials

# Showcase

Here is some pictures showing you what it looks like

Stealing sign:
![FiveM_GTAProcess_bVwNe4q9cG](https://github.com/user-attachments/assets/a712f61f-c186-410d-8e24-daac35944dcf)

Mini game while stealing sign:
![FiveM_GTAProcess_60r089Wlnr](https://github.com/user-attachments/assets/18bbe6cd-867f-4154-b640-06a73b2a808a)

Holding the sign:
![FiveM_GTAProcess_TuNvNjKSJe](https://github.com/user-attachments/assets/4ca7de8d-3c16-4c34-8b00-d43173db0342)

