#include <iostream>
#include <string>
#include <sstream>
using namespace std;

int main ()
{
  string str;
  auto otherstr = str;
  int count;

  cout << "Hello:";
  getline(cin, str);
  cout << "Other:";
  getline(cin, otherstr);
  cout << str << endl;
  cout << otherstr << endl;
  cout << "\nNumber:";
  getline(cin, str);
  stringstream ss(str);
  ss >> count;
  if (!ss.fail()) {
    cout << count << endl;
  } else {
    cout << "\"" << str << "\" can't be converted to int." << endl;
    return 1;
  }
  return 0;
}
