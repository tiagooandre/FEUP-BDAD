cmake_minimum_required(VERSION 3.15)
project(csv_to_sql)

set(CMAKE_CXX_STANDARD 14)

add_executable(csv_to_sql main.cpp CSVReader.cpp CSVReader.h InsertSQL.cpp InsertSQL.h)