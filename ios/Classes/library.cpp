#define MINIMP3_IMPLEMENTATION
#define MINIMP3_PREDECODE_FRAMES 2 /* frames to pre-decode and skip after seek (to fill internal structures) */
/*#define MINIMP3_SEEK_IDX_LINEAR_SEARCH*/ /* define to use linear index search instead of binary search on seek */
#define MINIMP3_IO_SIZE (128*1024) /* io buffer size for streaming functions, must be greater than MINIMP3_BUF_SIZE */
#define MINIMP3_BUF_SIZE (16*1024) /* buffer which can hold minimum 10 consecutive mp3 frames (~16KB) worst case */
#define MINIMP3_ENABLE_RING 0      /* enable hardware magic ring buffer if available, to make less input buffer memmove(s) in callback IO mode */

#include <iostream>
#include <fstream>
#include <list>
#include <limits>
#include <sstream>
#include "minimp3_ex.h"

extern "C" __attribute__((visibility("default"))) __attribute__((used))
const void extractWaveData(const char *fileName, const char *outputFileName) {
    static mp3dec_t mp3d;
    mp3dec_file_info_t info;
    mp3dec_init(&mp3d);
    bool error = mp3dec_load(&mp3d, fileName, &info, nullptr, nullptr);

    if (error) {
        return;
    }

    std::list<int> avs = std::list<int>();
    int _l = 0;
    int mn = std::numeric_limits<int>::infinity();
    int mx = std::numeric_limits<int>::infinity() * -1;

    for (int i = 0; i < info.samples; i++) {
        int t = info.buffer[i];
        if (t == 0) {
            continue;
        }
        if (_l == 512) {
            avs.emplace_back(mx);
            avs.emplace_back(mn);
            mn = std::numeric_limits<int>::infinity();
            mx = std::numeric_limits<int>::infinity() * -1;
            _l = 0;
        }
        mn = std::min(t, mn);
        mx = std::max(t, mx);
        ++_l;
    }
    if (_l > 0) {
        avs.emplace_back(mx);
        avs.emplace_back(mn);
    }
    // free(info.buffer);

    std::ofstream out_file;
    out_file.open(outputFileName);

    out_file << R"({"version":2,"channels":1,"sample_rate":44100,"samples_per_pixel":256,"bits":16,"length":)"
             << std::to_string(avs.size()) << R"(,"data":[)";
    int f = 0;
    for (int num : avs) {
        out_file << std::to_string(num);
        if (f < avs.size() - 1) out_file << ",";
        ++f;
    }
    out_file << "]}\0";
    out_file.close();
}
