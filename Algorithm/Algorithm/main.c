//
//  main.c
//  Algorithm
//
//  Created by FineexMac on 16/1/4.
//  Copyright © 2016年 LPiOS. All rights reserved.
//

#include <stdio.h>
#include "QuickSort.h"

int main(int argc, const char * argv[]) {
    int s[15] = {8,34,56,4,0,33,12,17,95,204,58,96,63,235,67};
    quick_sort(s, 15);
    return 0;
}

