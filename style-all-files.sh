#!/bin/bash
# Style all verilog files in project directory and user's V file
iStyle --indent=tab --style=kr --suffix=".old~" --pad=all */*.v */V/*.v
