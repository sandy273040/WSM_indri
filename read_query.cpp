#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <string>
#include <regex>
using namespace std;

vector<string> read_file(char* path){
    vector<string> query_vec;
    ifstream ifs(path, ios::in);
    if (!ifs.is_open()) {
        cout << "Failed to open file.\n";
        return query_vec;
    }

    string s;
    while(getline(ifs, s)){
        query_vec.push_back(s);
    }
    return query_vec;
}
void write_file(vector<string>& query_vec){
    regex period("\\.");
    regex punc(",");
    regex quot1("'s");//s reason: example - andy's
    regex quot2("s'");
    regex end_line("\\n");
    regex double_quot("\"");
    regex question("\\?");
    regex braket1("\\(");
    regex braket2("\\)");
    smatch m;
    ofstream ofs;
    ofs.open("query.txt");
    //write <parameter>
    ofs << "<parameters>\n";
    for(int i = 0; i < query_vec.size(); i++){
        if(query_vec[i].substr(0, 6) == "<desc>"){
            //write tab <query>
            ofs << "\t<query>\n";
            //cout << query_vec[i].substr(8, query_vec[i].length()) << endl;//wrtie tab tab content
            string text = "";
            for(int j = i+1; j < query_vec.size(); j++){
                if((query_vec[j][0] == '\n') || query_vec[j][0] == '<') break;

                string next_line = query_vec[j];
                next_line = regex_replace(next_line, punc, "");
                next_line = regex_replace(next_line, period, "");
                next_line = regex_replace(next_line, quot1, "");
                next_line = regex_replace(next_line, quot2, "");
                next_line = regex_replace(next_line, end_line, "");
                next_line = regex_replace(next_line, double_quot, "");
                next_line = regex_replace(next_line, question, "");
                next_line = regex_replace(next_line, braket1, "");
                next_line = regex_replace(next_line, braket2, "");

                text += " ";
                text += next_line;
            }
            
            if(text[text.length()-1] == '?') text = text.substr(0, text.length()-1);
            ofs << ("\t\t" + text + '\n');
            //write tab </query>
            ofs << "\t</query>\n";
        }
    }
    //write </parameter>
    ofs << "</parameters>";

    ofs.close();
}

int main() {
    char* path = "topics.401-450.txt";
    vector<string> query_vec = read_file(path);
    write_file(query_vec);

    return 0;
}