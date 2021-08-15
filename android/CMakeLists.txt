cmake_minimum_required(VERSION 3.4.1)  # for example

add_library( waveform
             # Sets the library as a shared library.
             SHARED
             # Provides a relative path to your source file(s).
             ../ios/Classes/library.cpp
)

find_library( # Defines the name of the path variable that stores the
              # location of the NDK library.
              log-lib

              # Specifies the name of the NDK library that
              # CMake needs to locate.
              log )

# Links your native library against one or more other native libraries.
target_link_libraries( # Specifies the target library.
                       waveform

                       # Links the log library to the target library.
                       ${log-lib} )
