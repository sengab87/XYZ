//
//  Num.cpp
//  test
//
//  Created by Ahmed Sengab on 10/1/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

#include "Num.hpp"

Num::Num(int n, int d){
    num = n * d;
}
int Num::getNum()
{
    return num;
} 
