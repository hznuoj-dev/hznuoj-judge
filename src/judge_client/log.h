#ifndef LOG_H_
#define LOG_H_

#include <cstdio>

#define LOG_INFO(fmt, ...)                                                 \
  printf(("\033[0;32m[INFO][%s:%d] " fmt "\n\033[0m"), __FILE__, __LINE__, \
         ##__VA_ARGS__)

#define LOG_WARN(fmt, ...)                                                 \
  printf(("\033[0;33m[INFO][%s:%d] " fmt "\n\033[0m"), __FILE__, __LINE__, \
         ##__VA_ARGS__)

#define LOG_ERROR(fmt, ...)                                                \
  printf(("\033[0;31m[INFO][%s:%d] " fmt "\n\033[0m"), __FILE__, __LINE__, \
         ##__VA_ARGS__)

#endif  // LOG_H_
