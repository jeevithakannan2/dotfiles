#include <stdio.h>

#include "../slstatus.h"
#include "../util.h"

const char *idle_inhibator(const char *unused) {
    FILE *fp = popen("pgrep -x hypridle", "r");
    
    char buff[128];
    if (fgets(buff, sizeof(buff), fp) !=NULL) {
        pclose(fp);
        return bprintf("");
    } else { 
        pclose(fp);
        return bprintf("    |");    
    }
}
