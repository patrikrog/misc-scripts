#!/usr/bin/env python3
# python script to get SMART information from disks, on illumos.

import subprocess
import json

# should not be including `pfexec` into the commands directly,
# but I'm lazy.
disks = subprocess.check_output(["pfexec diskinfo -Hp | awk '{print $2}'"], shell=True).decode('utf-8').splitlines()

for disk in disks:
    # ugly hack to exclude the nvme system disk and usb stick.
    if disk.startswith("c1t") or disk.startswith("c3t"):
        continue

    try:
        smartctl = subprocess.check_output([f"pfexec /opt/ooce/sbin/smartctl --json -d sat,12 -A /dev/rdsk/{disk}"], shell=True).decode('utf-8')
    except subprocess.CalledProcessError as e:
        smartctl = subprocess.check_output([f"pfexec /opt/ooce/sbin/smartctl --json -A /dev/rdsk/{disk}"], shell=True).decode('utf-8')

    smartinfo = json.loads(smartctl)
    disk_type = smartinfo["device"]["type"]
    match disk_type:
        case "scsi":
            scsi_defects = smartinfo["scsi_grown_defect_list"]
            hours = smartinfo["power_on_time"]["hours"]
            minutes = smartinfo["power_on_time"]["minutes"]
            print(f"Disk (type): {disk} ({disk_type}), hours: {hours}, minutes: {minutes}")
            print(f"\tSCSI Defects: {scsi_defects}")
        case "sat":
            attributes = [attr for attr in smartinfo["ata_smart_attributes"]["table"]]
            for attribute in attributes:
                match attribute['id']:
                    case 9:
                        print(f"Disk (type): {disk} ({disk_type}), hours: {attribute['raw']['string']}")
                    case 5 | 187 | 188 | 197 | 198:
                        if attribute['raw']['value'] > 0:
                            print(f"\t{attribute['name']} (id:{attribute['id']}): {attribute['raw']['string']}")
