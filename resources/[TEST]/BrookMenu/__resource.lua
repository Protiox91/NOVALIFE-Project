resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page 'html/ui.html'

files {
    'html/ui.html',
    'html/img/image.png',
    'html/css/app.css',
    'html/scripts/app.js'
}

client_scripts {
    "dependencies/Wrapper/Utility.lua",
    "dependencies/UIElements/UIVisual.lua",
    "dependencies/UIElements/UIResRectangle.lua",
    "dependencies/UIElements/UIResText.lua",
    "dependencies/UIElements/Sprite.lua",
    "dependencies/UIMenu/elements/Badge.lua",
    "dependencies/UIMenu/elements/Colours.lua",
    "dependencies/UIMenu/elements/ColoursPanel.lua",
    "dependencies/UIMenu/elements/StringMeasurer.lua",
    "dependencies/UIMenu/items/UIMenuItem.lua",
    "dependencies/UIMenu/items/UIMenuCheckboxItem.lua",
    "dependencies/UIMenu/items/UIMenuListItem.lua",
    "dependencies/UIMenu/items/UIMenuSliderItem.lua",
    "dependencies/UIMenu/items/UIMenuSliderHeritageItem.lua",
    "dependencies/UIMenu/items/UIMenuColouredItem.lua",
    "dependencies/UIMenu/items/UIMenuProgressItem.lua",
    "dependencies/UIMenu/items/UIMenuSliderProgressItem.lua",
    "dependencies/UIMenu/windows/UIMenuHeritageWindow.lua",
    "dependencies/UIMenu/panels/UIMenuGridPanel.lua",
    "dependencies/UIMenu/panels/UIMenuHorizontalOneLineGridPanel.lua",
    "dependencies/UIMenu/panels/UIMenuVerticalOneLineGridPanel.lua",
    "dependencies/UIMenu/panels/UIMenuColourPanel.lua",
    "dependencies/UIMenu/panels/UIMenuPercentagePanel.lua",
    "dependencies/UIMenu/panels/UIMenuStatisticsPanel.lua",
    "dependencies/UIMenu/UIMenu.lua",
    "dependencies/UIMenu/MenuPool.lua",
    "dependencies/UITimerBar/UITimerBarPool.lua",
    "dependencies/UITimerBar/items/UITimerBarItem.lua",
    "dependencies/UITimerBar/items/UITimerBarProgressItem.lua",
    "dependencies/UITimerBar/items/UITimerBarProgressWithIconItem.lua",
    "dependencies/UIProgressBar/UIProgressBarPool.lua",
    "dependencies/UIProgressBar/items/UIProgressBarItem.lua",
    "dependencies/NativeUI.lua",
    "@es_extended/locale.lua",
    "newmenu.lua"
}

server_scripts {
    "@es_extended/locale.lua",
    '@mysql-async/lib/MySQL.lua',
    "server.lua"

}