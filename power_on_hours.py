#!/usr/bin/env python3
# python script to get SMART information from disks, on illumos.

import subprocess
import json

disks = subprocess.check_output(["pfexec diskinfo -Hp | awk '{print $2}'"], shell=
True).decode('utf-8').splitlines()

for disk in disks:
    # ugly hack for ignoring the system nvme disk
    if disk.startswith('c1t'):
        continue
    smartinfo = subprocess.check_output([f"pfexec /opt/ooce/sbin/smartctl --json -
d sat,12 -A /dev/rdsk/{disk}"], shell=True).decode('utf-8')
    parsed_smartinfo = json.loads(smartinfo)
    attributes = [attr for attr in parsed_smartinfo["ata_smart_attributes"]["table
"]]
    for attribute in attributes:
        match attribute['id']:
            case 9:
                print(f"Disk: {disk}, Power on hours: {attribute['raw']['string']}
")
