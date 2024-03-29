"""
-g "-": delimitter of groups
-l: start list of groups
-o: specify out file, otherwise prints to stdout


gen.py -l .cpp - .h .hpp
"""

import os
import sys


def testExtension(fileName, extension):
    idx = fileName.find(extension)
    if idx != -1 and len(extension) + idx == len(fileName):
        return True, fileName[0 : idx]
    return False, ""

def stop():
    print("Error")
    exit()

def outCommand(command):
    if not outFileName is None:
        outFile = open(outFileName, "w")
        outFile.write(command + "\n")
        outFile.close()
    else:
        print(command)

groupDelim = "-"
outFileName = None

parseState = None

groups = []
currentGroup = []

if len(sys.argv) == 1:
    groups = [[".cpp"], [".h", ".hpp"]]
else:
    for arg in sys.argv[1 : ]:
        #-g, -i optional, come before -i
        if parseState is None:
            if arg == "-g":
                parseState = "-g"

            elif arg == "-i":
                parseState = "-i"

            elif arg == "-l":
                parseState = "-l"

            elif arg == "-o":
                parseState = "-o"

        elif parseState == "-g":
            groupDelim = arg
            parseState = None

        elif parseState == "-i":
            itemDelim = arg
            parseState = None

        elif parseState == "-o":
            outFileName = arg
            parseState = None

        elif parseState == "-l":
            if arg == groupDelim:
                groups.append(currentGroup)
                currentGroup = []
            else:
                currentGroup.append(arg)


    

if len(currentGroup) > 0:
    groups.append(currentGroup)
    currentGroup = []


files = sorted(os.listdir())


files2 = {}
for f in files:
    for g in range(len(groups)):
        for e in groups[g]:
            matches, root = testExtension(f, e)
            if matches:
                if not root in files2:
                    files2[root] = []
                files2[root].append([f, g])

fileList = []

for root in files2:
    info = files2[root]
    info = sorted(info, key = lambda x : x[1], reverse = True)

    for x in info:
        fileList.append(x[0])
    fileList.append(None)



if len(fileList) == 0:
    outCommand("vim")
    exit()

if fileList[-1] is None:
    fileList = fileList[0 : len(fileList) - 1]


command = "vim "


for i in range(len(fileList)):
    f = fileList[i]
    f2 = False if i + 1 >= len(fileList) else fileList[i + 1]

    if f is None:
        continue

    if i == 0:
        command += f
        if not f2 == False:
            command += " +\""
    
    else:
        if not (f is None or f == False):
            command += f

    sep = "" if i == 0 else " | "

    if f2 is None:
        command += sep + "tabnew "
    elif not f2 == False:
        command += sep + "vsplit "
    else:
        if i > 0:
            command += " | tabnext\""



outCommand(command)



