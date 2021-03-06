#ifndef OKCALLS_ARM_H_
#define OKCALLS_ARM_H_

#include "okcalls.h"

// C C++
int LANG_CV[CALL_ARRAY_SIZE] = {0, 3, 4, 5, 33, 45, 85, 122, 192, 197, 248, 0};

// pascal
int LANG_PV[CALL_ARRAY_SIZE] = {0, 3, 4, 54, 85, 174, 191, 248, 0};

// java
int LANG_JV[CALL_ARRAY_SIZE] = {0,   3,   5,   6,   11,  20,  33,  45,  85,
                                91,  120, 122, 125, 140, 174, 175, 191, 192,
                                195, 197, 240, 248, 256, 322, 338, 0};
//{0,2,3,5,6,19,33,45,85,91,120,122,125,174,175,191,192,195,197,240,248,256,322,338,0};

// ruby
int LANG_RV[CALL_ARRAY_SIZE] = {0, 0};

// bash
int LANG_BV[CALL_ARRAY_SIZE] = {0,   3,   4,   5,   6,   19,  20,  33,
                                45,  54,  63,  64,  65,  78,  122, 125,
                                140, 174, 175, 183, 191, 192, 195, 197,
                                199, 200, 201, 202, 221, 248, 0};

// python
int LANG_YV[CALL_ARRAY_SIZE] = {0,   3,   4,   5,   6,   19,  33,  41,  45,
                                54,  85,  91,  122, 125, 140, 174, 175, 183,
                                186, 191, 192, 195, 196, 197, 199, 200, 201,
                                202, 217, 221, 240, 248, 256, 322, 338, 0};
// php
int LANG_PHV[CALL_ARRAY_SIZE] = {0, 0};

// perl
int LANG_PLV[CALL_ARRAY_SIZE] = {0, 0};

// c-sharp
int LANG_CSV[CALL_ARRAY_SIZE] = {0,   3,   5,   6,   19,  33,  45,  122, 125,
                                 174, 175, 191, 192, 195, 197, 256, 338, 0};

// objective-c
int LANG_OV[CALL_ARRAY_SIZE] = {0, 0};

// freebasic
int LANG_BASICV[CALL_ARRAY_SIZE] = {0, 0};

// scheme
int LANG_SV[CALL_ARRAY_SIZE] = {0, 0};

// lua
int LANG_LUAV[CALL_ARRAY_SIZE] = {0, 0};

// nodejs
int LANG_JSV[CALL_ARRAY_SIZE] = {0, 0};

// go-lang
int LANG_GOV[CALL_ARRAY_SIZE] = {0, 0};

// sqlite3
int LANG_SQLV[CALL_ARRAY_SIZE] = {0, 0};

// fortran
int LANG_FV[CALL_ARRAY_SIZE] = {0, 3, 4, 5, 33, 45, 85, 122, 174, 197, 248, 0};

// matlib
int LANG_MV[CALL_ARRAY_SIZE] = {0,   2,   3,   4,   5,   6,   11,  19,  33,
                                45,  54,  78,  91,  122, 125, 140, 174, 175,
                                183, 191, 192, 195, 197, 199, 201, 217, 240,
                                242, 248, 256, 281, 283, 338, 384, 0};

#endif  // OKCALLS_ARM_H_
