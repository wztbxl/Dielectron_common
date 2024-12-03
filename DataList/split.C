#include <iostream>
#include "TString.h"

void split(const TString Energy = "9p2", const Int_t NUM = 50)
{
	gROOT->Reset();

	TString infile = Form("data_%s.list",Energy.Data());
	system(Form("mkdir -p filelist_%s",Energy.Data()));
	system(Form("rm -rf filelist_%s/*",Energy.Data()));
	system(Form("rm -rf datalist_%s",Energy.Data()));

	ifstream* inputStream = new ifstream;
	inputStream->open(infile);
	if (!(inputStream)) {
		cout << "can not open list file" << endl;
		return;
	}
	char line[512];
	// char outputfile[100];
	ofstream outDataList;
	outDataList.open(Form("datalist_%s",Energy.Data()));
	ofstream outData;
	for (int i=0;inputStream->good();i++) {
		inputStream->getline(line,512);
		if  ( inputStream->good() ) {
			if(i%NUM==0) {
				if(outData.is_open()) outData.close();
				// sprintf(outputfile,"filelist_all/%d.list",i/NUM);
				TString outputfile = Form("filelist_%s/%d.list",Energy.Data(),i/NUM);
				outData.open(outputfile);
				outDataList << outputfile << endl;
			}
			cout << " read in file " << line << endl;
			outData << line << endl;
		}
	}
	if(outData.is_open()) outData.close();
	outDataList.close();
}
