//
// Created by skidr on 03/04/2020.
//

#ifndef CSV_TO_SQL_CSVREADER_H
#define CSV_TO_SQL_CSVREADER_H

#include <string>
#include <vector>
#include <fstream>

using namespace std;

class CSVReader {
    ifstream file;
    string delimiter;

public:
    CSVReader(const string& filename, string delimiter);
    ~CSVReader();
    vector<vector<string>> getData();
};

class FileNotFound {
    string filename;
public:
    FileNotFound(const string &filename);

    const string &getFilename() const;

};

#endif //CSV_TO_SQL_CSVREADER_H
