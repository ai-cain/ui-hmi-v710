cmake_minimum_required(VERSION 3.16)

project(clock VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 COMPONENTS Quick Core REQUIRED)

# Adding Qt runtime path /opt/Qt-6.x/lib to default installation path for CrossControl displays
# The QT_HOST_PATH is set when cross-compiling, normally /opt/VM/Qt-6.x but not for the VM
if(NOT ${QT_HOST_PATH} STREQUAL "")
    string(REPLACE "/opt/VM" "/opt" QT_RUNTIME_PATH ${QT_HOST_PATH})
    string(APPEND QT_RUNTIME_PATH "/lib")
    set(CMAKE_INSTALL_RPATH ${QT_RUNTIME_PATH})
endif()

qt_add_executable(appclock
    main.cpp
)

qt_add_qml_module(appclock
    URI clock
    VERSION 1.0
    QML_FILES main.qml 
)

target_link_libraries(appclock
    PRIVATE Qt6::Quick)
    
target_include_directories(appclock PRIVATE /opt/crosscontrol/include)
    
if (CMAKE_SYSTEM_PROCESSOR STREQUAL aarch64)    
    message("Include CCAux for iMX8")
    target_compile_definitions(appclock PRIVATE CCAUX)
    target_link_libraries(appclock PRIVATE cc-aux2)
    
### Uncomment the following lines to add Sapcore support
#    message("Include Sapcore for iMX8")
#    target_link_directories(appclock PUBLIC /opt/crosscontrol/arm/imx8/lib)
#    target_link_libraries(appclock PRIVATE sapcore)

    set(TARGET_INSTALL_DIR "/opt/appclock/${CMAKE_INSTALL_BINDIR}")
endif()

if (CMAKE_SYSTEM_PROCESSOR STREQUAL x86_64)
### Uncomment the following lines to add Sapcore support
#    message("Include Sapcore for VM")
#    target_link_directories(appclock PUBLIC /opt/crosscontrol/x86_64/vm/lib)
#    target_link_libraries(appclock PRIVATE sapcore)

    set(TARGET_INSTALL_DIR ".")
endif()

install(TARGETS appclock
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${TARGET_INSTALL_DIR})
