# Enables fingerprint + installs TLP UI from flatpak
setup-t480s:
    #!/usr/bin/env bash
    echo 'Enabling zcfan.service'
    sudo systemctl enable zcfan.service
    echo 'Enabling fingerprint services'
    sudo systemctl start python3-validity.service
    sudo systemctl start open-fprintd.service
    sudo systemctl enable open-fprintd-resume.service open-fprintd-suspend.service open-fprintd.service python3-validity.service
    sudo authselect enable-feature with-fingerprint
    sudo authselect apply-changes
    sudo authselect current

# Installs Flameshot Flatpak & give screenshot permission
setup-flameshot:
     flatpak install --noninteractive --assumeyes org.flameshot.Flameshot
     flatpak permission-set screenshot screenshot org.flameshot.Flameshot yes