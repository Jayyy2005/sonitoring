cmake_minimum_required(VERSION 3.16)

project(sonitoring VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Quick Charts)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appsonitoring
    main.cpp
    CPUPageHandler.cpp
    GPUPageHandler.cpp
    RAMPageHandler.cpp

)

qt_add_resources(appsonitoring "resources.qrc")

qt_add_qml_module(appsonitoring
    URI sonitoring
    VERSION 1.0
    QML_FILES
        Main.qml
        HomePage.qml
        CPUPage.qml
        RAMPage.qml

        GPUPage.qml
    SOURCES
        CPUPageHandler.cpp
        GPUPageHandler.cpp
        RAMPageHandler.cpp
        CPUPageHandler.h
        GPUPageHandler.h
        RAMPageHandler.h
        CPUPageHandler.h
        resources.qrc
)

set_target_properties(appsonitoring PROPERTIES
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appsonitoring
    PRIVATE
        Qt6::Core
        Qt6::Gui
        Qt6::Quick
        Qt6::Charts
        Pdh

)

target_link_libraries(appsonitoring PRIVATE pdh)

link_directories(C:/Path/To/Windows/SDK/lib/x64)

include(GNUInstallDirs)
install(TARGETS appsonitoring
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
