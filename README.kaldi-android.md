# kaldi-android: Сборка Kaldi с OpenFST и OpenBLAS без CUDA

Минимальный путь для сборки Kaldi на Android (Termux) или Linux-машине, без CUDA, с использованием OpenFST и OpenBLAS.

## Требования

- `git`, `wget`, `tar`, `make`, `g++`, `gfortran`
- `python3` (в Termux: создайте симлинк `ln -s $(which python3) ~/../usr/bin/python`)
- Доступ к интернету

## Пошаговая инструкция

```bash
# Клонируем Kaldi
git clone https://github.com/kaldi-asr/kaldi.git kaldi-android
cd kaldi-android

# Инициализация под Android-сборку
cd tools

# Установка OpenFST
cd openfst-1.7.2
./configure --enable-static --disable-shared
make -j$(nproc)
cd ../..

# Создаем симлинки
cd tools/openfst-1.7.2
ln -s src/include include
mkdir lib
cp src/lib/.libs/libfst.a lib/
cd ../../

# Установка CUB
cd tools
wget https://github.com/NVlabs/cub/archive/1.8.0.tar.gz -O cub-1.8.0.tar.gz
tar -xzf cub-1.8.0.tar.gz
ln -s cub-1.8.0 cub

# Установка OpenBLAS
./extras/install_openblas.sh  # Если не сработает — см. ниже "ручной способ"