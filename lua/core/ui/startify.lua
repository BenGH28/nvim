local alpha = require 'alpha'
local startify = require 'alpha.themes.startify'
local ascii_art = {
  {
    [[░▒▓███████▓▒░  ░▒▓████████▓▒░  ░▒▓██████▓▒░  ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓██████████████▓▒░  ]],
    [[░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░        ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ]],
    [[░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░        ░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒▒▓█▓▒░  ░▒▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ]],
    [[░▒▓█▓▒░░▒▓█▓▒░ ░▒▓██████▓▒░   ░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒▒▓█▓▒░  ░▒▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ]],
    [[░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░        ░▒▓█▓▒░░▒▓█▓▒░   ░▒▓█▓▓█▓▒░   ░▒▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ]],
    [[░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░        ░▒▓█▓▒░░▒▓█▓▒░   ░▒▓█▓▓█▓▒░   ░▒▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ]],
    [[░▒▓█▓▒░░▒▓█▓▒░ ░▒▓████████▓▒░  ░▒▓██████▓▒░     ░▒▓██▓▒░    ░▒▓█▓▒░ ░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ]],
  },
  {
    [[                                   __                ]],
    [[      ___     ___    ___   __  __ /\_\    ___ ___    ]],
    [[     / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
    [[    /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
    [[    \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
    [[     \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
  },
  {
    [[ _        _______  _______          _________ _______ ]],
    [[( (    /|(  ____ \(  ___  )|\     /|\__   __/(       )]],
    [[|  \  ( || (    \/| (   ) || )   ( |   ) (   | () () |]],
    [[|   \ | || (__    | |   | || |   | |   | |   | || || |]],
    [[| (\ \) ||  __)   | |   | |( (   ) )   | |   | |(_)| |]],
    [[| | \   || (      | |   | | \ \_/ /    | |   | |   | |]],
    [[| )  \  || (____/\| (___) |  \   /  ___) (___| )   ( |]],
    [[|/    )_)(_______/(_______)   \_/   \_______/|/     \|]],
    [[                                                      ]],

  },
  {
    [[░   ░░░  ░░        ░░░      ░░░  ░░░░  ░░        ░░  ░░░░  ░]],
    [[▒    ▒▒  ▒▒  ▒▒▒▒▒▒▒▒  ▒▒▒▒  ▒▒  ▒▒▒▒  ▒▒▒▒▒  ▒▒▒▒▒   ▒▒   ▒]],
    [[▓  ▓  ▓  ▓▓      ▓▓▓▓  ▓▓▓▓  ▓▓▓  ▓▓  ▓▓▓▓▓▓  ▓▓▓▓▓        ▓]],
    [[█  ██    ██  ████████  ████  ████    ███████  █████  █  █  █]],
    [[█  ███   ██        ███      ██████  █████        ██  ████  █]],
  },
  {
    [[███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
    [[████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
    [[██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
    [[██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
    [[██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
    [[╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
    [[                                                  ]],
  },
  {
    [[      ::::    :::      ::::::::::      ::::::::    :::     :::      :::::::::::        :::   ::: ]],
    [[     :+:+:   :+:      :+:            :+:    :+:   :+:     :+:          :+:           :+:+: :+:+: ]],
    [[    :+:+:+  +:+      +:+            +:+    +:+   +:+     +:+          +:+          +:+ +:+:+ +:+ ]],
    [[   +#+ +:+ +#+      +#++:++#       +#+    +:+   +#+     +:+          +#+          +#+  +:+  +#+  ]],
    [[  +#+  +#+#+#      +#+            +#+    +#+    +#+   +#+           +#+          +#+       +#+   ]],
    [[ #+#   #+#+#      #+#            #+#    #+#     #+#+#+#            #+#          #+#       #+#    ]],
    [[###    ####      ##########      ########        ###          ###########      ###       ###     ]],
  }

}

math.randomseed(os.time())
local idx = math.random(#ascii_art)

startify.section.header.val = ascii_art[idx]
alpha.setup(startify.config)
