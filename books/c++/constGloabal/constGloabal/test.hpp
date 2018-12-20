//
//  test.hpp
//  constGloabal
//
//  Created by Ahmed Sengab on 12/9/18.
//  Copyright © 2018 Ahmed Sengab. All rights reserved.
//

#ifndef test_hpp
#define test_hpp
#include <iostream>
#include <stdio.h>
inline void testing();
using namespace std;
extern const int ahmed;
/*using namespace std;
 cout<<"test"<<endl;*/
inline void testing()
{
    std::cout<<ahmed<<std::endl;
    
}
#endif /* test_hpp */
