//
// Created by till on 28.07.20.
//
#include "library.h"

extern "C" __attribute__((visibility("default"))) __attribute__((used))
const char* extract_wave_data(const char* filePath) {
    return extractWaveData(filePath);
}