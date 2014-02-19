#!/usr/bin/env python

# Incomplete script for creating new projects from the DE0_TOP project
import os
import shutil
import sys

here = os.path.abspath(os.curdir)
if (not os.path.basename(here) == 'DE0_TOP') or (not len(sys.argv) > 1):
	exit()
print 't'

desired_name = sys.argv[1]

print desired_name
