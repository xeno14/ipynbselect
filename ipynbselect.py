#!/usr/bin/env python
# -*- coding: utf-8 -*-

import psutil


def find_notebook_server():
    notes = []
    for p in psutil.process_iter():
        if not p.name().startswith("ipython"):
            continue
        if "notebook" not in p.cmdline():
            continue
        for net in p.connections(kind="inet4"):
            if net.status != "LISTEN":
                continue
            _, port = net.laddr
            break
        notes.append({
            "pid": p.pid,
            "cwd": p.cwd(),
            "port": port,
        })
    return notes


if __name__ == '__main__':
    server = find_notebook_server()[0]
    print("{cwd} {port}".format(**server))
