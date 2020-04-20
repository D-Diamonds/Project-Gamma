Class = require 'lib/class'--creates "class" idea in lua
push = require 'lib/push'
bitser = require 'lib/bitser'
--makes all classes able to be used and accessed
require 'src/Util'
require 'src/constants'
require 'src/StateMachine'

-- States
require 'src/States/BaseState'
require 'src/States/StartState'
require 'src/States/PlayState'
require 'src/States/SettingsState'
require 'src/States/AchievementState'
require 'src/States/InstructionsState'
require 'src/States/MazeState'
require 'src/States/FlappyState'

-- GUI
require 'src/GUI/Clickable'
require 'src/GUI/Button'
require 'src/GUI/UpgradeMenu'
require 'src/GUI/Clock'
require 'src/GUI/FloorChanger'
require 'src/GUI/TriangleClickable'
require 'src/GUI/Popup'

require 'src/Floor'
require 'src/Grid'
require 'src/Cell'
require 'src/Cubicle'
require 'src/Worker'
require 'src/AchievementSystem'

require 'src/Player'
require 'src/Block'
require 'src/Wall'

require 'src/Bird'
require 'src/Pipe'

require'src/worker_defs.lua'
require 'Animation.lua'