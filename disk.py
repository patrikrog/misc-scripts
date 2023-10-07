#!/usr/bin/env python3
# python script to get SMART information from disks, on illumos.

import subprocess
import json

# should not be including `pfexec` into the commands directly,
# but I'm lazy.
disks = subprocess.check_output(["pfexec diskinfo -Hp | awk '{print $2}'"], shell=
True).decode('utf-8').splitlines()

for disk in disks:
    # ugly hack to exclude the nvme system disk
    if disk.startswith("c1t"):
        continue
    smartinfo = subprocess.check_output([f"pfexec /opt/ooce/sbin/smartctl --json -
d sat,12 -A /dev/rdsk/{disk}"], shell=True).decode('utf-8')
    parsed_smartinfo = json.loads(smartinfo)
    attributes = [attr for attr in parsed_smartinfo["ata_smart_attributes"]["table"]]
    for attribute in attributes:
        # print out attributes of disks that backblaze state are signs of early dying
        match attribute['id']:
            case 9:
                print(f"Disk: {disk}, hours: {attribute['raw']['string']}")
            case 5 | 187 | 188 | 197 | 198:
                if attribute['raw']['value'] > 0:
                    print(f"{attribute['name']} (id:{attribute['id']}): {attribute
['raw']['string']}")
