#include 'stdio.h' 
#include 'eclipse_io.h'


static int dev_code[] = {054,055,056}; 
int fps_code_payload[] = {0,0,0,0, 3,0o103000,0o2000,0o4430, 0o3,0o103000,0o2000,0o4430, 0o3,0o102000,0o2000,0o77, 0o3,0o104000,0o0,0o0, 0o0,0o0,0o0047444,0o100000, 0o03,0o103000,0o2000,0o100000, 0o0,0o0,0o0,0o0, 0o0,0o0,0o17444,0o100000, 0o1,0o10000,0o0,0o0, 0o0,0o0,0o0,0o120, 0o,0o,0o,0o,0o,0o,0o,0o}

int results_addr = 0o100; 
int load_addr = 0o200; 


int load[] = {0o1003, 0o1010, 0o1050, 0o1370}; 
int start = 0o40000; 
int stop = 0o100000; 

int load_ma = 0o1002;
int load_tma = 0o1003;
int examine_regmd =	0o2015;
int examine_regmd_o1 = 0o2035;
int examine_regmd_o2 = 0o02055;
int examine_regmd_o3 = 0o2075;

int examine_regpsa = 0o2000;
int examine_regtma = 0o2003;

int wtsr = 0o21031;
int wtfn = 0o22031;
int rdfn = 0o22030;
int rdlt = 0o23030;



int main(void) { 
outa(dev_code[0],load_addr); 
outa(dev_code[1],wstr)

outa
}


