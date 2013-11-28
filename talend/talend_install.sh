#!/bin/bash
#

rm -rf /usr/local/bin/talend
mkdir /usr/local/bin/talend

unzip "/tmp/salt/install/talend_latest.zip" "Runtime_ESBSE/*" -d "/usr/local/bin/talend"


# writing the state line
echo  # an empty line here so the next line will be the last.
if [ $? -eq 0 ]
then
  echo "changed=yes comment='installed OK' whatever=123"
else
  echo "changed=no comment='error during unzip' whatever=123"
fi