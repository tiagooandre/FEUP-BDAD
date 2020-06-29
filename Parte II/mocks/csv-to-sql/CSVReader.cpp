//
// Created by skidr on 03/04/2020.
//

#include "CSVReader.h"

#include <exception>
#include <utility>

CSVReader::CSVReader(const string& filename, string delimiter) {
    this->delimiter = std::move(delimiter);
    this->file = ifstream(filename);

    if (!this->file.is_open()) {
        throw FileNotFound(filename);
    }
}

vector<string> parseString(string s, string delimiter) {
    vector<string> line;
    size_t pos = 0;
    string token;
    while ((pos = s.find(delimiter)) != string::npos) {
        token = s.substr(0, pos);
        line.push_back(token);
        s.erase(0, pos + delimiter.length());
    }
    line.push_back(s);
    return line;
}

vector<vector<string>> CSVReader::getData() {
    vector<vector<string>> data;

    string line;
    getline(this->file, line);                  // skip header
    while (getline(this->file, line)) {
        data.push_back(parseString(line, ";"));
    }

    return data;
}

CSVReader::~CSVReader() {
    this->file.close();
}



// Exception class

FileNotFound::FileNotFound(const string &filename) : filename(filename) {

}

const string &FileNotFound::getFilename() const {
    return filename;
}
