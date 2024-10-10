# Minimum CMake version required
cmake_minimum_required(VERSION 3.16)

# Project name and version
project(TQ_GUI VERSION 0.1 LANGUAGES CXX)

# Enable automatic MOC (Meta-Object Compiler) for Qt
set(CMAKE_AUTOMOC ON)

# Set C++ standard to C++17
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find required Qt6 packages
find_package(Qt6 COMPONENTS Core Quick Network REQUIRED)

# Add executable target for the application
qt_add_executable(appTQ_GUI
    main.cpp
    CppInterface.h
    CppInterface.cpp
)

# Add QML module to the target
qt_add_qml_module(appTQ_GUI
    URI TQ_GUI
    VERSION 1.0
    QML_FILES
        main.qml
)

# Set target properties for macOS and Windows
set_target_properties(appTQ_GUI PROPERTIES
    # MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appTQ_GUI # Uncomment and set this for iOS/macOS
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

# Link Qt libraries to the target
target_link_libraries(appTQ_GUI
    PRIVATE Qt6::Quick Qt6::Network Qt6::Core
)

# Include GNUInstallDirs module for standard installation directories
include(GNUInstallDirs)

# Install target with specified destinations
install(TARGETS appTQ_GUI
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
