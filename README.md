# dotfiles

Managed by **mise**, **Homebrew**, and **apt**.

## 🎨 Fonts

- **UDEV Gothic JPDOC**: Primary font used across the environment.
  - [Download (GitHub: yuru7/udev-gothic)](https://github.com/yuru7/udev-gothic)

## 🚀 Quick Start

```sh
curl -L https://raw.githubusercontent.com/awayatakuma/dotfiles/main/install.sh | sh
```

## 🧪 Local Testing

### Ubuntu
Requires [**Podman**](https://podman.io/). Verify the installation in a clean Ubuntu container:

```sh
tar --no-xattrs --no-mac-metadata -cf - . | podman run -i --rm ubuntu:24.04 bash -c '
    export DEBIAN_FRONTEND=noninteractive; \
    apt-get update && apt-get install -y sudo git curl ca-certificates tar > /dev/null; \
    useradd -m -s /bin/bash testuser && echo "testuser ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers; \
    mkdir -p /home/testuser/projects/dotfiles && tar -xf - -C /home/testuser/projects/dotfiles; \
    chown -R testuser:testuser /home/testuser/projects; \
    su - testuser -c "cd ~/projects/dotfiles && ./scripts/setup.bash" && \
    echo "--- FULL INSTALL TEST PASSED! ---"
'
```
