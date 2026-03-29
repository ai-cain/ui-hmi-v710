cmake_minimum_required(VERSION 3.16)

project(UiHmiV710 VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if (MSVC)
    add_compile_options(/FS)
endif()

find_package(Qt6 6.4 COMPONENTS Quick Core REQUIRED)
#find_package(Qt6 REQUIRED COMPONENTS VirtualKeyboard)

# Adding Qt runtime path /opt/Qt-6.x/lib to default installation path for CrossControl displays
# The QT_HOST_PATH is set when cross-compiling, normally /opt/VM/Qt-6.x but not for the VM
if(NOT ${QT_HOST_PATH} STREQUAL "")
    string(REPLACE "/opt/VM" "/opt" QT_RUNTIME_PATH ${QT_HOST_PATH})
    string(APPEND QT_RUNTIME_PATH "/lib")
    set(CMAKE_INSTALL_RPATH ${QT_RUNTIME_PATH})
endif()

# Añadir recursos
qt_add_resources(RESOURCES qml.qrc)

qt_add_executable(appUiHmiV710
    main.cpp
    ${RESOURCES} #necesario para el qrc
)

qt_add_qml_module(appUiHmiV710
    URI UiHmiV710
    VERSION 1.0

    QML_FILES
    main.qml
    components/Mtk_Slider.qml
    components/Mtk_Button.qml

    pages/Page_1.qml
    pages/Page_2.qml
    pages/Page_3.qml
    pages/Page_4.qml
    pages/Page_5.qml
    pages/Page_6.qml
    pages/Page_7.qml
    pages/PowerPage.qml
    pages/P_OperacionesSlider.qml
    pages/DateTimePage.qml

    pages/MTKTouch.qml

    pages/MTKOrientation.qml


    components/StatusFieldControl.qml
    components/CCIPAddressText.qml

    components/CCLogo.qml
    #components/NavigationBar.qml
    #components/ButtonTempl.qml
    #components/Controller.qml

    #pages/MainMenuPage.qml
    #pages/ListData.qml
    #pages/ListItem.qml
    #pages/ListItem.qml
    pages/VersionsPage.qml
    pages/FrontLedPage.qml
    pages/BuzzerPage.qml
    pages/BacklightPage.qml
    components/PageHeaderControl.qml
    components/PageTitleControl.qml
    components/CCSlider.qml
    components/CCLedHeader.qml
    components/CCSynth.qml
    components/CCSynthKey.qml
    components/CCCheckBox.qml
    components/CCToggleButton.qml
    components/DateTimeDialog.qml
    #js/Suma.js

    #-- keyboard --
    SOURCES legacy/keyboard/keyEmitter.h
    QML_FILES legacy/keyboard/Keyboard.qml
    QML_FILES legacy/keyboard/KeyboardController.qml
    QML_FILES legacy/keyboard/CustomButtonKeyboard.qml
    # -- clock --
    SOURCES legacy/clock/Clock.h
    SOURCES legacy/clock/Clock.cpp

    RESOURCES
    graphics/logo.png
    SOURCES
    others/operacion.h              others/operacion.cpp
    others/suma.h                   others/suma.cpp
    backend/backend.h               backend/backend.cpp
    backend/displayConfigHandler.h  backend/displayConfigHandler.cpp
    backend/hwbutton.h              backend/hwbutton.cpp
    backend/ipaddress.h             #
    backend/appstate.h              #
    CCAux/CCAuxHandlerBase.h        #
    CCAux/FrontLedHandler.h         CCAux/FrontLedHandler.cpp
    CCAux/BackLightHandler.h        CCAux/BackLightHandler.cpp
    CCAux/BuzzerHandler.h           CCAux/BuzzerHandler.cpp
    CCAux/VersionHandler.h          CCAux/VersionHandler.cpp
    CCAux/PowerConfigHandler.h      CCAux/PowerConfigHandler.cpp


    graphics/alarm.svg
    graphics/alarm-white.svg
    graphics/home.svg
    graphics/home-white.svg
    graphics/navigation.svg
    graphics/navigation-white.svg
    graphics/settings.svg
    graphics/settings-white.svg
    graphics/camera-outline.svg
    graphics/under-construction.png
)

target_link_libraries(appUiHmiV710
    PRIVATE
    Qt6::Quick
    Qt6::Qml
    #Qt6::VirtualKeyboard
)

target_include_directories(appUiHmiV710 PRIVATE /opt/crosscontrol/include)

if (CMAKE_SYSTEM_PROCESSOR STREQUAL aarch64)    
    message("Include CCAux for iMX8")
    target_compile_definitions(appUiHmiV710 PRIVATE CCAUX)
    target_link_libraries(appUiHmiV710 PRIVATE cc-aux2)
    
    message("Include Sapcore for iMX8")
    target_link_directories(appUiHmiV710 PUBLIC /opt/crosscontrol/arm/imx8/lib)
    target_link_libraries(appUiHmiV710 PRIVATE sapcore)

    set(TARGET_INSTALL_DIR "/opt/appUiHmiV710/${CMAKE_INSTALL_BINDIR}")
endif()

if (CMAKE_SYSTEM_PROCESSOR STREQUAL x86_64)
    message("Include Sapcore for VM")
    target_link_directories(appUiHmiV710 PUBLIC /opt/crosscontrol/x86_64/vm/lib)
    target_link_libraries(appUiHmiV710 PRIVATE sapcore)

    set(TARGET_INSTALL_DIR ".")
endif()

install(TARGETS appUiHmiV710
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${TARGET_INSTALL_DIR}
)
