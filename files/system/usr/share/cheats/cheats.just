# Sets up kernel arguments for fan control & sysrq + local initramfs regeneration + enables fingerprint + installs TLP UI from flatpak
setup-t480s:
    #!/usr/bin/env bash
    echo 'Applying kernel arguments'
    rpm-ostree kargs \
      --append-if-missing="thinkpad_acpi.fan_control=1" \
      --append-if-missing="sysrq_always_enabled=1" 
    echo 'Enabling local initramfs regeneration'
    rpm-ostree initramfs --enable
    echo 'Enabling fingerprint services'
    sudo systemctl enable zcfan.service
    sudo systemctl start python3-validity.service
    sudo systemctl start open-fprintd.service
    sudo systemctl enable open-fprintd-resume.service open-fprintd-suspend.service open-fprintd.service python3-validity.service
    sudo authselect enable-feature with-fingerprint
    sudo authselect apply-changes
    sudo authselect current
    echo 'Installing TLP-UI Flatpak'
    flatpak install --system flathub --noninteractive --assumeyes com.github.d4nj1.tlpui
    echo 'Remember to reboot!' 

# Installs Flameshot Flatpak & give screenshot permission
setup-flameshot:
     flatpak install --noninteractive --assumeyes org.flameshot.Flameshot
     flatpak permission-set screenshot screenshot org.flameshot.Flameshot yes