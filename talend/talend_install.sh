#!/bin/bash
#
cat /etc/iptables/rules | grep -E "^COMMIT$|^\*filter$|^#.*$|^$" --invert-match > /tmp/iptables.rules.orig

iptables -S > /tmp/iptables.rules.active

diff /tmp/iptables.rules.orig /tmp/iptables.rules.active

# writing the state line
echo  # an empty line here so the next line will be the last.
if [ $? -eq 0 ]
then
  echo "changed=no comment='nothing has changed' whatever=123"
else
  echo "changed=yes comment='something has changed' whatever=123"
fi