# install_virtualgl

```bash
rm -rf .tmp/virtualgl

bash src/ubuntu/install/virtualgl/install_virtualgl_dl.sh

# deb
mkdir -p .tmp/virtualgl/virtualgl_3.1_amd64/DEBIAN/ && \
dpkg -X .tmp/virtualgl/virtualgl_3.1_amd64.deb .tmp/virtualgl/virtualgl_3.1_amd64/ && \
dpkg -e .tmp/virtualgl/virtualgl_3.1_amd64.deb .tmp/virtualgl/virtualgl_3.1_amd64/DEBIAN/

sudo dpkg -i .tmp/virtualgl/virtualgl_3.1_amd64.deb
sudo apt install -f -y
```
