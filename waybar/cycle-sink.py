#!/usr/bin/env python
import sys
import subprocess

def run(cmd):
    return subprocess.check_output(cmd, text=True).strip()

def list_sinks():
    # returns list of sink names in order
    out = run(["pactl", "list", "short", "sinks"])
    sinks = []
    for line in out.splitlines():
        parts = line.split()
        if len(parts) >= 2:
            sinks.append(parts[1])
    return sinks

def main():
    sinks = list_sinks()
    if len(sys.argv) == 1 or len(sinks) < 1:
        return

    cmd = sys.argv[1]
    default = run(["pactl", "get-default-sink"])

    default_index = sinks.index(default)
    if default_index == -1:
        return

    new_sink = None
    if cmd == "next":
        new_sink = sinks[(default_index + 1) % len(sinks)]
    elif cmd == "prev":
        new_sink = sinks[(default_index - 1) % len(sinks)]

    run(["pactl", "set-default-sink", new_sink])
    

if  __name__ == "__main__":
    main()

