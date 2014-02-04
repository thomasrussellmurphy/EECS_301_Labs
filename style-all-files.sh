#!/bin/bash
# Style all verilog files 1, 2, 3 levels down
# May just error @3rd level
iStyle --indent=tab --style=kr --suffix=".old~" --pad=all */*.v */*/*.v */*/*/*.v