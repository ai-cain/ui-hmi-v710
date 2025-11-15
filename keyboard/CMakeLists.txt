cmake_minimum_required(VERSION 3.16)

project(CustomKey VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 COMPONENTS Quick REQUIRED)

# Adding Qt runtime path /opt/Qt-6.x/lib to default installation path for CrossControl displays
# The QT_HOST_PATH is set when cross-compiling, normally /opt/VM/Qt-6.x but not for the VM
if(NOT ${QT_HOST_PATH} STREQUAL "")
    string(REPLACE "/opt/VM" "/opt" QT_RUNTIME_PATH ${QT_HOST_PATH})
    string(APPEND QT_RUNTIME_PATH "/lib")
    set(CMAKE_INSTALL_RPATH ${QT_RUNTIME_PATH})
endif()

qt_add_executable(appCustomKey
    main.cpp
    keyEmitter.h
)

qt_add_qml_module(appCustomKey
    URI CustomKey
    VERSION 1.0
    QML_FILES
    main.qml
    SOURCES keyEmitter.h
    QML_FILES Keyboard.qml
    QML_FILES KeyboardController.qml
    QML_FILES
    QML_FILES CustomButtonKeyboard.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.

set_target_properties(appCustomKey PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appCustomKey
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appCustomKey
    PRIVATE Qt6::Quick)





target_include_directories(appCustomKey PRIVATE /opt/crosscontrol/include)

if (CMAKE_SYSTEM_PROCESSOR STREQUAL aarch64)
    message("Include CCAux for iMX8")
    target_compile_definitions(appCustomKey PRIVATE CCAUX)
    target_link_libraries(appCustomKey PRIVATE cc-aux2)

    message("Include Sapcore for iMX8")
    target_link_directories(appCustomKey PUBLIC /opt/crosscontrol/arm/imx8/lib)
    target_link_libraries(appCustomKey PRIVATE sapcore)

    set(TARGET_INSTALL_DIR "/opt/appDEMO3/${CMAKE_INSTALL_BINDIR}")
endif()

if (CMAKE_SYSTEM_PROCESSOR STREQUAL x86_64)
    message("Include Sapcore for VM")
    target_link_directories(appCustomKey PUBLIC /opt/crosscontrol/x86_64/vm/lib)
    target_link_libraries(appCustomKey PRIVATE sapcore)

    set(TARGET_INSTALL_DIR ".")
endif()






include(GNUInstallDirs)
install(TARGETS appCustomKey
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    RUNTIME DESTINATION ${TARGET_INSTALL_DIR}
)
