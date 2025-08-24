#!/bin/sh

#
# Where do you want to install Midnight Commander?
#
export MC_INSTALL_DIRECTORY=/usr/local


#
# Set temporary paths
#
export path_to_build=$PWD/tmp/builddir
export path_to_source=$PWD/tmp/srcdir
export path_to_install=$PWD/tmp/installdir
mkdir -p $path_to_build
mkdir -p $path_to_source
mkdir -p $path_to_install

export PATH=$path_to_install/bin:$PATH


#
# Select packages
#
M4_VERSION="1.4.20"
AUTOCONF_VERSION="2.72"
AUTOMAKE_VERSION="1.18.1"
LIBTOOL_VERSION="2.5.4"
PKGCONFIG_VERSION="0.29.2"
LIBFFI_VERSION="3.5.2"
NINJA_VERSION="1.13.1"
MESON_VERSION="1.8.4"
GLIB_MAJOR_VERSION="2.85"
GLIB_MINOR_VERSION="4"
MC_VERSION="4.8.33"

PARALLEL_JOBS=8

M4_SELECT=y
AUTOCONF_SELECT=y
AUTOMAKE_SELECT=y
LIBTOOL_SELECT=y
PKGCONFIG_SELECT=y
LIBFFI_SELECT=y
NINJA_SELECT=y
MESON_SELECT=y
GLIB_SELECT=y
MC_SELECT=y


#
# Download packages
#
if [ $M4_SELECT = y ] && [ ! -f $path_to_source/m4-$M4_VERSION.tar.gz ]; then
  echo "Download m4-$M4_VERSION"
  cd $path_to_source; curl -OL https://ftpmirror.gnu.org/m4/m4-$M4_VERSION.tar.gz
fi
if [ $AUTOCONF_SELECT = y ] && [ ! -f $path_to_source/autoconf-$AUTOCONF_VERSION.tar.gz ]; then
  echo "Download autoconf-$AUTOCONF_VERSION"
  cd $path_to_source; curl -OL https://ftpmirror.gnu.org/autoconf/autoconf-$AUTOCONF_VERSION.tar.gz
fi
if [ $AUTOMAKE_SELECT = y ] && [ ! -f $path_to_source/automake-$AUTOMAKE_VERSION.tar.gz ]; then
  echo "Download automake-$AUTOMAKE_VERSION"
  cd $path_to_source; curl -OL https://ftpmirror.gnu.org/automake/automake-$AUTOMAKE_VERSION.tar.gz
fi
if [ $LIBTOOL_SELECT = y ] && [ ! -f $path_to_source/libtool-$LIBTOOL_VERSION.tar.gz ]; then
  echo "Download libtool-$LIBTOOL_VERSION"
  cd $path_to_source; curl -OL https://ftpmirror.gnu.org/libtool/libtool-$LIBTOOL_VERSION.tar.gz
fi
if [ $PKGCONFIG_SELECT = y ] && [ ! -f $path_to_source/pkg-config-$PKGCONFIG_VERSION.tar.gz ]; then
  echo "Download pkg-config-$PKGCONFIG_VERSION"
  cd $path_to_source; curl -OL https://pkgconfig.freedesktop.org/releases/pkg-config-$PKGCONFIG_VERSION.tar.gz
fi
if [ $LIBFFI_SELECT = y ] && [ ! -f $path_to_source/libffi-$LIBFFI_VERSION.tar.gz ]; then
  echo "Download libffi-$LIBFFI_VERSION"
  cd $path_to_source; curl -OL https://github.com/libffi/libffi/releases/download/v$LIBFFI_VERSION/libffi-$LIBFFI_VERSION.tar.gz
fi
if [ $NINJA_SELECT = y ] && [ ! -f $path_to_source/ninja-$NINJA_VERSION.tar.gz ]; then
  echo "Download ninja-$NINJA_VERSION"
  cd $path_to_source; curl -L https://github.com/ninja-build/ninja/archive/refs/tags/v$NINJA_VERSION.tar.gz -o ninja-$NINJA_VERSION.tar.gz
fi
if [ $MESON_SELECT = y ] && [ ! -f $path_to_source/meson-$MESON_VERSION.tar.gz ]; then
  echo "Download meson-$MESON_VERSION"
  cd $path_to_source; curl -OL https://github.com/mesonbuild/meson/releases/download/$MESON_VERSION/meson-$MESON_VERSION.tar.gz
fi
if [ $GLIB_SELECT = y ] && [ ! -f $path_to_source/glib-$GLIB_MAJOR_VERSION.$GLIB_MINOR_VERSION.tar.xz ]; then
  echo "Download glib-$GLIB_MAJOR_VERSION.$GLIB_MINOR_VERSION"
  cd $path_to_source; curl -OL https://ftp.gnome.org/pub/gnome/sources/glib/$GLIB_MAJOR_VERSION/glib-$GLIB_MAJOR_VERSION.$GLIB_MINOR_VERSION.tar.xz
fi
if [ $MC_SELECT = y ] && [ ! -f $path_to_source/mc-$MC_VERSION.tar.bz2 ]; then
  echo "Download mc-$MC_VERSION"
  cd $path_to_source; curl -OL http://ftp.midnight-commander.org/mc-$MC_VERSION.tar.bz2
fi
echo "Download complete!"


#
# Build packages
#

#
# M4
#
if [ $M4_SELECT = y ]; then
rm -rf $path_to_build/m4-$M4_VERSION
tar xzf $path_to_source/m4-$M4_VERSION.tar.gz -C $path_to_build
cd $path_to_build/m4-$M4_VERSION
./configure --prefix=$path_to_install
make -j $PARALLEL_JOBS
make install
fi

#
# Autoconf
#
if [ $AUTOCONF_SELECT = y ]; then
rm -rf $path_to_build/autoconf-$AUTOCONF_VERSION
tar xzf $path_to_source/autoconf-$AUTOCONF_VERSION.tar.gz -C $path_to_build
cd $path_to_build/autoconf-$AUTOCONF_VERSION
./configure --prefix=$path_to_install
make -j $PARALLEL_JOBS
make install
fi

#
# Automake
#
if [ $AUTOMAKE_SELECT = y ]; then
rm -rf $path_to_build/automake-$AUTOMAKE_VERSION
tar xzf $path_to_source/automake-$AUTOMAKE_VERSION.tar.gz -C $path_to_build
cd $path_to_build/automake-$AUTOMAKE_VERSION
./configure --prefix=$path_to_install
make -j $PARALLEL_JOBS
make install
fi

#
# Libtool
#
if [ $LIBTOOL_SELECT = y ]; then
rm -rf $path_to_build/libtool-$LIBTOOL_VERSION
tar xzf $path_to_source/libtool-$LIBTOOL_VERSION.tar.gz -C $path_to_build
cd $path_to_build/libtool-$LIBTOOL_VERSION
./configure --prefix=$path_to_install --enable-static --disable-shared
make -j $PARALLEL_JOBS
make install
fi

#
# Pkg-config
#
if [ $PKGCONFIG_SELECT = y ]; then
rm -rf $path_to_build/pkg-config-$PKGCONFIG_VERSION
tar xzf $path_to_source/pkg-config-$PKGCONFIG_VERSION.tar.gz -C $path_to_build
cd $path_to_build/pkg-config-$PKGCONFIG_VERSION
CFLAGS="-Wno-int-conversion" ./configure --prefix=$path_to_install -with-internal-glib --disable-host-tool --with-system-include-path=$path_to_install/include:/usr/include --with-system-library-path=$path_to_install/lib:/usr/lib:/lib LIBS="-Wl,-framework -Wl,CoreFoundation -Wl,-framework -Wl,Cocoa"
make -j $PARALLEL_JOBS
make install
fi

#
# LibFFI
#
if [ $LIBFFI_SELECT = y ]; then
rm -rf $path_to_build/libffi-$LIBFFI_VERSION
tar xzf $path_to_source/libffi-$LIBFFI_VERSION.tar.gz -C $path_to_build
cd $path_to_build/libffi-$LIBFFI_VERSION
./configure --prefix=$path_to_install --enable-static --disable-shared
make -j $PARALLEL_JOBS
make install
fi

#
# Ninja
#
if [ $NINJA_SELECT = y ]; then
rm -rf $path_to_build/ninja-$NINJA_VERSION
tar xzf $path_to_source/ninja-$NINJA_VERSION.tar.gz -C $path_to_build
cd $path_to_build/ninja-$NINJA_VERSION
./configure.py --bootstrap
cp -a ninja $path_to_install/bin
fi

#
# Meson
#
if [ $MESON_SELECT = y ]; then
rm -rf $path_to_build/meson-$MESON_VERSION
tar xzf $path_to_source/meson-$MESON_VERSION.tar.gz -C $path_to_build
cd $path_to_build/meson-$MESON_VERSION
./packaging/create_zipapp.py --outfile meson.pyz --interpreter '/usr/bin/env python3'
cp -a meson.pyz $path_to_install/bin
fi

#
# Glib
#
if [ $GLIB_SELECT = y ]; then
rm -rf $path_to_build/glib-$GLIB_MAJOR_VERSION.$GLIB_MINOR_VERSION
tar xvfJ $path_to_source/glib-$GLIB_MAJOR_VERSION.$GLIB_MINOR_VERSION.tar.xz -C $path_to_build
cd $path_to_build/glib-$GLIB_MAJOR_VERSION.$GLIB_MINOR_VERSION
CFLAGS="-I$path_to_install/include" CXXFLAGS="-I$path_to_install/include" LDFLAGS="-L$path_to_install/lib" meson.pyz setup --prefix=$path_to_install --default-library=static -D nls=disabled -D glib_debug=disabled -D tests=false -D sysprof=disabled _build
meson.pyz compile -C _build
meson.pyz install -C _build
fi

#
# Midnight Commander
#
if [ $MC_SELECT = y ]; then
rm -rf $path_to_build/mc-$MC_VERSION
tar xjf $path_to_source/mc-$MC_VERSION.tar.bz2 -C $path_to_build
cd $path_to_build/mc-$MC_VERSION
CFLAGS="-I$path_to_install/include" LDFLAGS="-L$path_to_install/lib" ./configure --prefix=$MC_INSTALL_DIRECTORY --disable-nls --with-libintl-prefix="$path_to_install" --with-pcre2="$path_to_install" --enable-static --with-screen=ncurses --with-glib-static=yes GLIB_LIBDIR="$path_to_install/lib" GLIB_LIBS="$path_to_install/lib/libglib-2.0.a $path_to_install/lib/libintl.a -liconv -lm -framework Foundation -framework CoreFoundation -framework AppKit -framework Carbon -lpcre2-8" GMODULE_LIBS="$path_to_install/lib/libgmodule-2.0.a" LIBS="$path_to_install/lib/libgmodule-2.0.a $path_to_install/lib/libintl.a $path_to_install/lib/libglib-2.0.a $path_to_install/lib/libintl.a -liconv -lm -framework Foundation -framework CoreFoundation -framework AppKit -framework Carbon -lpcre2-8"
make -j $PARALLEL_JOBS
echo "Enter password to complete installation to $MC_INSTALL_DIRECTORY"
sudo make install
fi

echo "Midnight Commander installed to $MC_INSTALL_DIRECTORY with minimum dependencies"
