%define debug_package %{nil}
%define spotifyrepo http://repository.spotify.com/pool/non-free/s/spotify

Summary: Spotify music player.
Name: spotify-client
Version: 0.9.11.27
Release: 1%{?dist}
URL: https://www.spotify.com
Packager: Sjir Bagmeijer <sbagmeijer@ulyaoth.co.kr>
License: Proprietary(non-free)
Group: Applications/Multimedia
Vendor: Spotify Ltd
BuildArch: x86_64
AutoReqProv: no
Source0: ulyaoth-spotify.tar.gz

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

Provides: spotify
Provides: spotify-client
Provides: ulyaoth-spotify
Provides: ulyaoth-spotify-client

%description
Spotify is a commercial music streaming service providing digital rights management–restricted[4] content from record labels including Sony, EMI, Warner Music Group and Universal.[5][6] Music can be browsed or searched by artist, album, genre, playlist, or record label. Paid "Premium" subscriptions remove advertisements and allow users to download music to listen to offline.[7] On computers, a link allows users to purchase selected material via partner retailers.

%setup -q

%build

%install

tar xvf %{SOURCE0} -C $RPM_BUILD_ROOT

%clean
%{__rm} -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root)

%dir /opt/spotify
%dir /opt/spotify/spotify-client
%dir /opt/spotify/spotify-client/Data
%dir /opt/spotify/spotify-client/Data/locales
%dir /opt/spotify/spotify-client/Icons
%dir %{_defaultdocdir}/spotify-client-gnome-support
%dir %{_defaultdocdir}/spotify-client-qt
%dir %{_defaultdocdir}/spotify-client
%dir %{_datadir}/spotify
/opt/spotify/spotify-client/*
/opt/spotify/spotify-client/Data/*
/opt/spotify/spotify-client/Icons/*
/opt/spotify/spotify-client/Data/locales/*
/usr/lib64/*
%{_defaultdocdir}/spotify-client-gnome-support/*
%{_defaultdocdir}/spotify-client-qt/*
%{_defaultdocdir}/spotify-client/*
%{_bindir}/*
%{_datadir}/applications/*
/usr/share/applications/spotify.desktop
/usr/share/icons/hicolor/16x16/apps/spotify-client.png
/usr/share/icons/hicolor/22x22/apps/spotify-client.png
/usr/share/icons/hicolor/24x24/apps/spotify-client.png
/usr/share/icons/hicolor/32x32/apps/spotify-client.png
/usr/share/icons/hicolor/48x48/apps/spotify-client.png
/usr/share/icons/hicolor/64x64/apps/spotify-client.png
/usr/share/icons/hicolor/128x128/apps/spotify-client.png
/usr/share/icons/hicolor/256x256/apps/spotify-client.png

%postun
gtk-update-icon-cache %{_datadir}/icons/hicolor &>/dev/null || :

%post
# print site info
    cat <<BANNER
----------------------------------------------------------------------

Thanks for using Spotify!

Please find the official documentation for Spotify here:
* https://www.spotify.com/

----------------------------------------------------------------------
BANNER

%changelog
* Sat Oct 4 2014 Sjir Bagmeijer <sbagmeijer@ulyaoth.co.kr> 0.9.11.27-1
- Creating new clean spec file.
- Support for Fedora 19, 20 and 21.
- Support for RHEL 6 and 7.