#include <iostream>
#include <fstream>
#include <sstream> 
#include <string>

using namespace std;

int main(){
  ifstream oldFile("sqlTuples/members.sql");
  ofstream newFile("sqlTuples/newMembers.sql");
  
  string line, tmp;
  istringstream iss;
  
  while(getline(oldFile, line)){
    iss.str(line);

    getline(iss, tmp, ')');
    newFile << tmp << ")";

    for(int i = 0; i < 5; i++){
      getline(iss, tmp, ',');
      newFile << tmp << ",";
    }
getline(iss, tmp, ',');

    newFile << " " << ((rand() % 249) + 1) <<",";
    getline(iss, tmp, ';');

    newFile << tmp << ";" << "\n";
  }

  oldFile.close();
  newFile.close();
  return 0;
}