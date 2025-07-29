#!/bin/bash

FILE="$1"

if [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" || "$OSTYPE" == "cygwin" ]]; then
    # Use PowerShell for Windows
    powershell -Command "Remove-Item -Path '$FILE' -Force"
else
    # Use rm for Unix-based systems
    rm -f "$FILE"
fi
