%define debug_package %{nil}
%define spotifyrepo http://repository.spotify.com/pool/non-free/s/spotify

Summary: Spotify music player.
Name: spotify-client
Version: 0.9.11.27
Release: 1%{?dist}
URL: https://www.spotify.com
Packager: Sjir Bagmeijer <sbagmeijer@ulyaoth.co.kr>
License: Proprietry (non-free)
Group: Applications/Multimedia
Vendor: Spotify Ltd
Source0: ulyaoth-spotify.tar.gz

BuildRequires:  desktop-file-utils
BuildRequires:  python2-devel
BuildRequires:  redhat-lsb-core
BuildRequires:  openssl-devel

Requires: zenity
Requires: qt-x11
Requires: hicolor-icon-theme
Requires: openssl
Requires: libXScrnSaver
Requires: GConf2
Requires: alsa-lib
Requires: glibc
Requires: libstdc++
Requires: usbutils
Requires: xdg-utils
Requires: gtk2
Requires: nss
Requires: nspr
Requires: glib2

%changelog
* Sat Oct 4 2014 Sjir Bagmeijer <sbagmeijer@ulyaoth.co.kr> 0.9.11.27-1
- Creating new clean spec file.
- Support for Fedora 19, 20 and 21.
- Support for RHEL 6 and 7.