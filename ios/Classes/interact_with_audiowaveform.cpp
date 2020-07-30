//
// Created by till on 28.07.20.
//
#include "library.h"

extern "C" __attribute__((visibility("default"))) __attribute__((used))
const char* extract_wave_data(const char* filePath) {
    const char* data = extractWaveData(filePath);
    return "LIES IN RETURN PART 2";
    return data;
}