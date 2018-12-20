#include <iostream>
#include <string>
#include <sstream>
#include "Num.hpp"

using namespace std;

struct movies_t {
    string title;
    int year;
};

int main ()
{
    string mystr;
    Num n (35 , 5);
    cout << n.getNum() << endl;
    return 0; 
    movies_t amovie;
    movies_t * pmovie;
    pmovie = &amovie;
    
    cout << "Enter title: ";
    getline (cin, pmovie->title);
    cout << "Enter year: ";
    getline (cin, mystr);
    (stringstream) mystr >> pmovie->year;
    
    cout << "\nYou have entered:\n";
    cout << pmovie->title;
    cout << " (" << pmovie->year << ")\n";
    
    cout<<amovie.title<<endl;
    cout<<amovie.year<<endl;
    //return 0;
    amovie.title = "zobr";
    cout<<pmovie->title<<endl;
}
