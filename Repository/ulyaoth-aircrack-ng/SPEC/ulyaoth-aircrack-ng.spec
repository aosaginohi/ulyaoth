Summary: Aircrack-ng is an 802.11 WEP and WPA-PSK keys cracking program that can recover keys once enough data packets have been captured.
Name: ulyaoth-aircrack-ng
Version: 1.2
Release: 1%{?dist}
BuildArch: x86_64
Vendor: Aspyct.org
URL: https://www.aircrack-ng.org/
Packager: Sjir Bagmeijer <sbagmeijer@ulyaoth.net>
License: GPLv2
Group: Applications/Internet

Source0: http://download.aircrack-ng.org/aircrack-ng-1.2-rc2.tar.gz

BuildRoot: %{_tmppath}/aircrack-ng-root

BuildRequires: openssl-devel
BuildRequires: sqlite-devel
BuildRequires: pcre-devel
BuildRequires: libnl3-devel

Provides: aircrack-ng
Provides: ulyaoth-aircrack-ng

%description
Aircrack-ng is an 802.11 WEP and WPA-PSK keys cracking program that can recover keys once enough data packets have been captured. It implements the standard FMS attack along with some optimizations like KoreK attacks, as well as the PTW attack, thus making the attack much faster compared to other WEP cracking tools.

%prep
%setup -q -n aircrack-ng-1.2-rc2

%build
%configure --prefix=""
make pcre=true sqlite=true

%install
%{__rm} -rf $RPM_BUILD_ROOT
%{__make} DESTDIR=$RPM_BUILD_ROOT pcre=true sqlite=true install

%clean
%{__rm} -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root)


%pre

%post
cat <<BANNER
----------------------------------------------------------------------

Thanks for using ulyaoth-aircrack-ng!

Please find the official documentation for aircrack-ng here:
* https://www.aircrack-ng.org/

For any additional help please visit my forum at:
* https://www.ulyaoth.net

----------------------------------------------------------------------
BANNER

%preun

%postun

%changelog
* Sun Sep 6 2015 Sjir Bagmeijer <sbagmeijer@ulyaoth.net> - 1.2-1
- Initial release.