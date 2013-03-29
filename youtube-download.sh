#!/bin/bash
youtube-dl -f 18 -o '%(title)s.%(ext)s' $*
