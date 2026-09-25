

---


```shell
rsync \
    -e "ssh -p 2222" \
    -rhav \
    --progress \
    --delete-before \
    /home/michael/git/repos/flakes \
    nixos@localhost:/home/nixos/
```


```shell
rsync \
    -e "ssh -p 2222" \
    -rhav \
    --progress \
    nixos@localhost:/home/nixos/flakes/my-test-flake-01/REAMDE.md \
    /home/michael/git/repos/flakes/REAMDE.mc \
    
```


```shell
cd flakes/my-test-flake-01/
sudo chown -R nixos:users .git \
    && nix flake update \
    && git add -A \
    && nix flake check \
    && nix flake show
```

```shell
sudo nixos-rebuild build-vm --flake .#nixos-qemu --verbose
./result/bin/run-nixos-vm -m 16G
```


```shell
createEmptyFilesystemImage() {
  local name=$1
  local size=$2
  local temp=$(mktemp)
  /nix/store/nbx16xqar4k00m1yhv7vjdz2sb91m64x-qemu-host-cpu-only-10.2.4/bin/qemu-img create -f raw "$temp" "$size"
  /nix/store/k79ra63k4vr2srkwvjrqcppm5pamac5n-e2fsprogs-1.47.4-bin/bin/mkfs.ext4 -L nixos "$temp"
  /nix/store/nbx16xqar4k00m1yhv7vjdz2sb91m64x-qemu-host-cpu-only-10.2.4/bin/qemu-img convert -f raw -O qcow2 "$temp" "$name"
  rm "$temp"
}

NIX_DISK_IMAGE=$(readlink -f "${NIX_DISK_IMAGE:-./nixos-qemu.qcow2}") || test -z "$NIX_DISK_IMAGE"

createEmptyFilesystemImage "$NIX_DISK_IMAGE" "20G"
# Formatting '/tmp/tmp.dBpDH0AwWe', fmt=raw size=21474836480
# mke2fs 1.47.4 (6-Mar-2025)
# Discarding device blocks: done                            
# Creating filesystem with 5242880 4k blocks and 1310720 inodes
# Filesystem UUID: 99924d3f-47a6-46c3-a49a-adc86214e45a
# Superblock backups stored on blocks: 
#         32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208, 
#         4096000
# 
# Allocating group tables: done                            
# Writing inode tables: done                            
# Creating journal (32768 blocks): done
# Writing superblocks and filesystem accounting information: done   
```