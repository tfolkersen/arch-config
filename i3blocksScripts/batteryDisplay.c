#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

const char *levelErrStr = "err";

const char * const batteryStateStrs[] = {"Discharging", "Charging", "Full", "Not charging"};

enum batteryStates {
    DISCHARGING = 0,
    CHARGING,
    FULL,
    NOT_CHARGING,
};

const int nBatteryStates = sizeof(batteryStateStrs) / sizeof(batteryStateStrs[0]);


int main() {
    int bufferLen = 256;
    char buffer[bufferLen];

    bool err = false;

    ////Get battery level
    FILE *f;

    f = popen("cat /sys/class/power_supply/BAT0/capacity 2>&1", "r");

    if (f == NULL) {
        printf("popen failed\n");
        return 0;
    }

    memset(buffer, 0, bufferLen);
    fgets(buffer, bufferLen, f);
    pclose(f);
    f = NULL;


    //terminate at newline
    for (int i = 0; i < bufferLen; i++) {
        char c = buffer[i];

        if (c == 0) {
            break;
        }

        if (c == '\n') {
            buffer[i] = 0;
            break;
        }
    }

    int levelLen = strlen(buffer);

    //Check numeric
    for (int i = 0; i < levelLen; i++) {
        char c = buffer[i];

        // 0 --> ASCII 48
        // 9 --> ASCII 57
        if (c < 48 || c > 57) {
            err = true;
            break;
        }
    }

    int level;

    if (err) {
        level = -1;
        err = false;
    } else {
        level = atoi(buffer);
    }


    ////Get charge threshold (limit)
    err = false;

    f = popen("cat /sys/class/power_supply/BAT0/charge_stop_threshold 2>&1", "r");

    if (f == NULL) {
        printf("popen failed\n");
        return 0;
    }

    memset(buffer, 0, bufferLen);
    fgets(buffer, bufferLen, f);
    pclose(f);
    f = NULL;


    //terminate at newline
    for (int i = 0; i < bufferLen; i++) {
        char c = buffer[i];

        if (c == 0) {
            break;
        }

        if (c == '\n') {
            buffer[i] = 0;
            break;
        }
    }

    int limitLen = strlen(buffer);

    //Check numeric
    for (int i = 0; i < limitLen; i++) {
        char c = buffer[i];

        // 0 --> ASCII 48
        // 9 --> ASCII 57
        if (c < 48 || c > 57) {
            err = true;
            break;
        }
    }

    int limit;

    if (err) {
        limit = -1;
        err = false;
    } else {
        limit = atoi(buffer);
    }

    ////Get battery state
    err = false;

    f = popen("cat /sys/class/power_supply/BAT0/status 2>&1", "r");

    if (f == NULL) {
        printf("popen failed\n");
        return 0;
    }

    memset(buffer, 0, bufferLen);
    fgets(buffer, bufferLen, f);
    pclose(f);
    f = NULL;

    //terminate at newline
    for (int i = 0; i < bufferLen; i++) {
        char c = buffer[i];

        if (c == 0) {
            break;
        }

        if (c == '\n') {
            buffer[i] = 0;
            break;
        }
    }

    int statusLen = strlen(buffer);
    char status[statusLen + 1];
    strncpy(status, buffer, statusLen);
    status[statusLen] = 0;

    int batteryStateID = -1;

    for (int i = 0; i < nBatteryStates; i++) {
        const char *term = batteryStateStrs[i];

        if (strstr(status, term)) {
            batteryStateID = i;
            break;
        }
    }


    switch (batteryStateID) {
        case DISCHARGING:
            printf("%d%%\n", level);
            break;

        case CHARGING:
            printf("[%d%%]\n", level);
            break;

        case FULL:
            printf("[%d%% FULL]\n", level);
            break;

        case NOT_CHARGING:
            if (limit == -1) {
                printf("!?%d%%!?\n", level);
            } else if (level + 1 >= limit) {
                printf("[%d%% Full]\n", level);
            } else {
                printf("!!%d%%!!\n", level);
            }

            break;

        default:
            printf("??d%%??\n", level);
            break;
    }

    return 0;
}
