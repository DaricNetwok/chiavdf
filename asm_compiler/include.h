#ifndef INCLUDE_H
#define INCLUDE_H

#if defined(__AVX512BW__) || \
    defined(__AVX512CD__) || \
    defined(__AVX512DQ__) || \
    defined(__AVX512F__) || \
    defined(__AVX512VL__)
#define __AVX512__
#endif

#ifdef NDEBUG
#undef NDEBUG
#endif

#if VDF_MODE == 0
#define NDEBUG
#endif

#include <iostream>
#include <string>
#include <vector>
#include <cstdio>
#include <iostream>
#include <memory>
#include <stdexcept>
#include <string>
#include <array>
#include <sstream>
#include <fstream>

#ifndef _WIN32

#include <unistd.h>

typedef unsigned __int128 uint128;
typedef __int128 int128;
#define USED __attribute__((used))
#else
#include "uint128_t/uint128_t.h"
#define USED
#endif

#include <cassert>
#include <iomanip>
#include <set>
#include <random>
#include <limits>
#include <cstdlib>
#include <map>
#include <functional>
#include <algorithm>
#include <cstdint>
#include <deque>
#include <cfenv>
#include <ctime>
#include <thread>
#include "generic.h"
#include <gmpxx.h>

using namespace std;
using namespace generic;

typedef uint8_t uint8;
typedef uint16_t uint16;
typedef uint32_t uint32;
typedef uint64_t uint64;
typedef int8_t int8;
typedef int16_t int16;
typedef int32_t int32;
typedef int64_t int64;

#define todo

#endif // INCLUDE_H
