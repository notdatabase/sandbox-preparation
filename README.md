# Windows Sandbox Preparation Script
A preparation script for Windows Sandbox that installs basic dependencies and debugging tools.

## The Why
Windows Sandbox is a great tool for testing and debugging unknown software. However, its ephemeral design is the greatest strength and weakness, as while nothing will persist, installing your debug tools manually every time you want to do reverse engineering can be a pain.

This script will fetch common debugging and utility scripts, so you can save time and have everything ready in just a few seconds or a minute.

## Script Versions
There are 2 versions of the script. All of them do the same thing:
* [Main](https://github.com/notdatabase/sandbox-preparation/blob/main/Main.wsb) - Plays [Eiffel 65 - Blue 8-Bit Remix](https://www.youtube.com/watch?v=RB7VBfiMRKA) during installation.
* [Silent](https://github.com/notdatabase/sandbox-preparation/blob/main/Main-Silent.wsb) - Does not play the installation music.

Run the .wsb file to start the sandbox.

## Software
* Brave
* 7-Zip
* Sysinternals Suite
* Nirsoft Launcher w/ all NirSoft Utilities
* Python 3
* dnSpy
* Notepad++
* x64dbg

## System Settings
* Dark theme
* File extensions showed
* Hidden files enabled