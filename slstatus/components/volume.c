/* See LICENSE file for copyright and license details. */
#include <stdio.h>
#include <stdbool.h>
#include <string.h>

#include "../slstatus.h"
#include "../util.h"

const char *
vol_perc(const char *unused)
{
	char line[256];
	short b;
	
	FILE *fp = popen("pactl get-sink-mute @DEFAULT_SINK@", "r");
	char mute[4];
    fgets(line, sizeof(line), fp);
    sscanf(line, "Mute: %s", mute);
    pclose(fp);

    if (!strncmp(mute, "yes", 3)) {
        // If muted, return 0% volume
        return bprintf(" 0%%");
    } else {
        // Get the current volume level
        fp = popen("pactl get-sink-volume @DEFAULT_SINK@", "r");
        fgets(line, sizeof(line), fp);
        sscanf(line, "Volume: front-left: %*d /  %hd", &b);
        pclose(fp);
        // Return the formatted volume level
        return bprintf(" %d%%", b);
    }
}
