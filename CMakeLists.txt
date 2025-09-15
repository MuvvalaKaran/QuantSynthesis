cmake_minimum_required(VERSION 3.10)
project(QuantSynthesis LANGUAGES C CXX)

# Set the C++ standard
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# Compiler flags
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -pthread -O3")

# Include directories
include_directories(${CMAKE_SOURCE_DIR})
include_directories(${CMAKE_SOURCE_DIR}/cudd-2.5.1/include)

# Add the CUDD libraries
set(CUDD_LIBS
    ${CMAKE_SOURCE_DIR}/cudd-2.5.1/obj/libobj.a
    ${CMAKE_SOURCE_DIR}/cudd-2.5.1/cudd/libcudd.a
    ${CMAKE_SOURCE_DIR}/cudd-2.5.1/mtr/libmtr.a
    ${CMAKE_SOURCE_DIR}/cudd-2.5.1/st/libst.a
    ${CMAKE_SOURCE_DIR}/cudd-2.5.1/util/libutil.a
    ${CMAKE_SOURCE_DIR}/cudd-2.5.1/epd/libepd.a
)

add_library(aiger STATIC aiger.c)

# Add the source files
set(SOURCES
    main.cpp
    energyGames.cpp
    #aiger.c
)

# Add the headers
set(HEADERS
    energyGames.h
    aiger.h
)

# Add the executable
add_executable(main ${SOURCES} ${HEADERS})

# Link the CUDD libraries
target_link_libraries(main ${CUDD_LIBS} aiger)

# Link the AIGER library if it exists
find_library(AIGER_LIB aiger PATHS /usr/local/lib /usr/lib /lib NO_DEFAULT_PATH)
if(AIGER_LIB)
    target_link_libraries(main ${AIGER_LIB})
else()
    message(WARNING "AIGER library not found. Ensure it is installed and available.")
endif()