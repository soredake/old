#!/bin/sh
adb root
adb remount
#
# Create a minimal but safe SSH Daemon configuration
cat <<EndOfSSHDConfigFile > /tmp/sshd_config
# Minimal OpenSSH daemon configuration for CyanogenMod 10.1+
AuthorizedKeysFile /data/.ssh/authorized_keys
ChallengeResponseAuthentication no
PasswordAuthentication no
PermitRootLogin without-password
Subsystem sftp internal-sftp
pidfile /data/ssh/sshd.pid
EndOfSSHDConfigFile
#
# Install on Android device
adb push /tmp/sshd_config /data/ssh/
#
# Install personal SSH public key on Android device
adb push "$HOME/.ssh/id_ed25519.pub" /data/.ssh/authorized_keys
#
# Create host keys and adjust file permissions on the device
adb shell ssh-keygen -A
adb shell chmod 600 /data/.ssh/authorized_keys
adb shell chmod 644 /data/ssh/sshd_config
#
# Create a service script for the SSH daemon
cat <<EndOfSSHDServiceScript > /tmp/sshd-start.sh
#!/system/bin/sh
# OpenSSH daemon startup script for Android CyanogenMod
# DEBUG=1
#
# Generate host keys, if not already existing
ssh-keygen -A
if [ "1" == "$DEBUG" ] ; then
  # run sshd in debug mode and capture output to logcat
  /system/bin/logwrapper /system/bin/sshd -D -d
else
  # don't daemonize - otherwise we can't stop the sshd service
  /system/bin/sshd -D
fi
EndOfSSHDServiceScript

#
# Install our service script on the Android device:
adb push /tmp/sshd-start.sh /data/ssh/
adb shell chmod 755 /data/ssh/sshd-start.sh
#adb shell mkdir -p /data/local/userinit.d
#adb shell ln -s /data/ssh/sshd-start.sh /data/local/userinit.d/90sshd
