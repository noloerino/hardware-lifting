#!/usr/bin/python3.6

import sys
import configfile

print("(_ bv{} {})".format(int(sys.argv[1][-2:], 16), configfile.outputwidths[0]))
