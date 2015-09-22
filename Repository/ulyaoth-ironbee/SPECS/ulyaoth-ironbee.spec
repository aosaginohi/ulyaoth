#
%define debug_package %{nil}
%define ironbee_home %{_sysconfdir}/ironbee
%define ironbee_user ironbee
%define ironbee_group ironbee

Summary: IronBee WAF Framework
Name: ulyaoth-ironbee
Version: 0.12.2
Release: 1%{?dist}
BuildArch: x86_64
Vendor: Qualys, Inc.
Group: System Environment/Daemons
URL: https://www.ironbee.com/
Packager: Sjir Bagmeijer <sbagmeijer@ulyaoth.net>

Source0: https://github.com/ironbee/ironbee/archive/v%{version}.tar.gz
Source1: https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/Repository/ulyaoth-ironbee/SOURCES/ironbee.conf

License: 2-clause BSD-like license

Requires: openssl
Requires: geoip
Requires: boost-chrono
Requires: boost-date-time
Requires: boost-filesystem
Requires: boost-iostreams
Requires: boost-program-options
Requires: boost-regex
Requires: boost-system
Requires: boost-thread
Requires: pcre
Requires: zlib
Requires: libxml2
Requires: uuid

BuildRoot: %{_tmppath}/ironbee-%{version}-%{release}-root
BuildRequires: autoconf
BuildRequires: automake
BuildRequires: libtool
BuildRequires: gcc
BuildRequires: gcc-c++
BuildRequires: pcre-devel
BuildRequires: zlib-devel
BuildRequires: libxml2-devel
BuildRequires: uuid-devel
BuildRequires: geoip-devel
BuildRequires: openssl-devel
BuildRequires: curl-devel
BuildRequires: yajl-devel
BuildRequires: libpcap-devel
BuildRequires: libnet-devel
BuildRequires: ruby-devel
BuildRequires: boost-devel
BuildRequires: boost-build

Provides: ironbee
Provides: ulyaoth-ironbee

%description
The next-generation open source web application firewall engine, designed to be modular, portable, and efficient, and to give you the tools you need to defend sites from attack.

%package debug
Summary: debug version of nginx compiled with Ironbee Open Source WAF. 
Group: System Environment/Daemons
Requires: ulyaoth-nginx-ironbee
%description debug
Not stripped version of nginx built with the debugging log support and compiled with Ironbee Open Source WAF.

%prep
%setup -q -n ironbee-%{version}

%build

./autogen.sh
./configure \
  --prefix=/usr \
  --exec-prefix=%{_exec_prefix} \
  --bindir=%{_bindir} \
  --sbindir=%{_sbindir} \
  --libexecdir=%{_libexecdir} \
  --sysconfdir=%{_sysconfdir} \
  --sharedstatedir=%{_sharedstatedir} \
  --localstatedir=%{_localstatedir} \
  --libdir=%{_libdir} \
  --includedir=%{_includedir} \
  --oldincludedir=%{_includedir} \
  --datarootdir=%{_datadir} \
  --datadir=%{_datadir} \
  --infodir=%{_infodir} \
  --localedir=/usr/share/locale \
  --mandir=%{_mandir} \
  --docdir=%{_docdir} \
  --htmldir=%{_docdir} \
  --dvidir=%{_docdir} \
  --pdfdir=%{_docdir} \
  --psdir=%{_docdir} \
  --with-manager-control-socket=%{_localstatedir}/run/ironbee/ironbee_manager_controller.sock \
  CFLAGS="-fno-omit-frame-pointer -g" CXXFLAGS="-fno-omit-frame-pointer -g" \
        $*
make %{?_smp_mflags}


%install
%{__rm} -rf $RPM_BUILD_ROOT
%makeinstall DESTDIR=$RPM_BUILD_ROOT install

mkdir -p $RPM_BUILD_ROOT%{_localstatedir}/run/ironbee

%{__install} -m 644 -p %{SOURCE1} \
   $RPM_BUILD_ROOT/etc/tmpfiles.d/ironbee.conf

%clean
%{__rm} -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root)

%{_sbindir}/nginx

%dir %{_sysconfdir}/nginx
%dir %{_sysconfdir}/nginx/conf.d
%dir %{_sysconfdir}/nginx/sites-available
%dir %{_sysconfdir}/nginx/sites-enabled
%dir %{_sysconfdir}/nginx/modules
%{_sysconfdir}/nginx/modules/*

%config(noreplace) %{_sysconfdir}/nginx/nginx.conf
%config(noreplace) %{_sysconfdir}/nginx/conf.d/default.conf
%config(noreplace) %{_sysconfdir}/nginx/conf.d/example_ssl.conf
%config(noreplace) %{_sysconfdir}/nginx/mime.types
%config(noreplace) %{_sysconfdir}/nginx/fastcgi_params
%config(noreplace) %{_sysconfdir}/nginx/scgi_params
%config(noreplace) %{_sysconfdir}/nginx/uwsgi_params
%config(noreplace) %{_sysconfdir}/nginx/koi-utf
%config(noreplace) %{_sysconfdir}/nginx/koi-win
%config(noreplace) %{_sysconfdir}/nginx/win-utf

%config(noreplace) %{_sysconfdir}/logrotate.d/nginx
%config(noreplace) %{_sysconfdir}/sysconfig/nginx

%dir %{_datadir}/nginx
%dir %{_datadir}/nginx/html
%{_datadir}/nginx/html/*

%attr(0755,root,root) %dir %{_localstatedir}/cache/nginx
%attr(0755,root,root) %dir %{_localstatedir}/log/nginx

%files debug
%attr(0755,root,root) %{_sbindir}/nginx.debug

%pre
# Add the "ironbee" user
getent group %{ironbee_group} >/dev/null || groupadd -r %{ironbee_group}
getent passwd %{ironbee_user} >/dev/null || \
    useradd -r -g %{ironbee_group} -s /sbin/nologin \
    -d %{ironbee_home} -c "ironbee user"  %{ironbee_user}
exit 0

%post
    # print site info
    cat <<BANNER
----------------------------------------------------------------------

Thanks for using ulyaoth-ironbee!

Please find the official Ironbee documentation here:
* https://www.ironbee.com/

For any additional help please visit my forum at:
* https://www.ulyaoth.net

----------------------------------------------------------------------
BANNER

%preun

%postun


%changelog
* Tue Sep 22 2015 Sjir Bagmeijer <sbagmeijer@ulyaoth.net> 0.12.2-1
- Initial release of Ironbee 0.12.2.