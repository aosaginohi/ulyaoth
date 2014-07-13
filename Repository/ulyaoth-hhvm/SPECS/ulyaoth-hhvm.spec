#
%define hhvm_home %{_sysconfdir}/hhvm
%define hhvm_user hhvm
%define hhvm_group hhvm

Summary: HHVM virtual machine, runtime, and JIT for the PHP language
Name: ulyaoth-hhvm
Version: 3.1.0
Release: 1%{?dist}
URL: http://www.hhvm.com/
Vendor: Facebook.
Packager: Sjir Bagmeijer <sbagmeijer@ulyaoth.co.kr>

Source0: hhvm-%{version}.tar.gz
Source1: https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/guides/xenforo/linux/hhvm/php.ini
Source2: https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/guides/xenforo/linux/hhvm/config.hdf
Source3: https://raw.githubusercontent.com/sbagmeijer/ulyaoth/master/guides/xenforo/linux/hhvm/server.hdf

License: GPL

Requires: boost
Requires: glog

BuildRoot: %{_tmppath}/hhvm-%{version}
BuildRequires: autoconf
BuildRequires: automake
BuildRequires: make
BuildRequires: cmake
BuildRequires: libtool
BuildRequires: cpp
BuildRequires: gcc-c++
BuildRequires: git
BuildRequires: binutils-devel
BuildRequires: boost-devel
BuildRequires: bzip2-devel
BuildRequires: curl-devel
BuildRequires: expat-devel
BuildRequires: elfutils-libelf-devel
BuildRequires: gd-devel
BuildRequires: glog-devel
BuildRequires: ImageMagick-devel
BuildRequires: jemalloc-devel
BuildRequires: libc-client-devel
BuildRequires: libcap-devel
BuildRequires: libcurl-devel
BuildRequires: libdwarf-devel
BuildRequires: libedit-devel
BuildRequires: libevent-devel
BuildRequires: libicu-devel
BuildRequires: libmcrypt-devel
BuildRequires: libmemcached-devel
BuildRequires: libxslt-devel
BuildRequires: libxml2-devel
BuildRequires: libyaml-devel
BuildRequires: mysql-devel
BuildRequires: pam-devel
BuildRequires: pcre-devel
BuildRequires: ocaml
BuildRequires: oniguruma-devel
BuildRequires: openldap-devel
BuildRequires: readline-devel
BuildRequires: tbb-devel
BuildRequires: zlib-devel

Provides: hhvm
Provides: ulyaoth-hhvm

%description 
HHVM is an open-source virtual machine designed for executing programs written in Hack and PHP. HHVM uses a just-in-time (JIT) compilation approach to achieve superior performance while maintaining the development flexibility that PHP provides.

%prep
%setup -q -n hhvm-%{version}

%build 
export CMAKE_PREFIX_PATH=`pwd`
cmake .
make

%install
%{__mkdir} -p $RPM_BUILD_ROOT%{_localstatedir}/log/hhvm
%{__mkdir} -p $RPM_BUILD_ROOT%{_localstatedir}/run/hhvm
%{__mkdir} -p $RPM_BUILD_ROOT%{_sysconfdir}/hhvm
%{__install} -m 644 -p %{SOURCE1} \
   $RPM_BUILD_ROOT%{_sysconfdir}/hhvm/php.ini
%{__install} -m 644 -p %{SOURCE2} \
   $RPM_BUILD_ROOT%{_sysconfdir}/hhvm/config.hdf
%{__install} -m 644 -p %{SOURCE3} \
   $RPM_BUILD_ROOT%{_sysconfdir}/hhvm/server.hdf

%pre
getent group %{hhvm_group} >/dev/null || groupadd -r %{hhvm_group}
getent passwd %{hhvm_user} >/dev/null || \
    useradd -r -g %{hhvm_group} -s /sbin/nologin \
    -d %{hhvm_home} -c "hhvm user"  %{hhvm_user}
exit 0

%files
%defattr(-,root,root,-)
%dir %{_sysconfdir}/hhvm
%config(noreplace) %{_sysconfdir}/hhvm/config.hdf
%config(noreplace) %{_sysconfdir}/hhvm/php.ini
%config(noreplace) %{_sysconfdir}/hhvm/server.hdf
/etc/rc.d/init.d/hhvm
/usr/bin/hhvm
/usr/lib/hhvm
/usr/lib/hhvm/libevent-1.4.so.2
/usr/lib/hhvm/libglog.so.0
/usr/share/hhvm
/usr/share/hhvm/LICENSE
/usr/share/hhvm/THIRD_PARTY
/usr/share/hhvm/hdf
/usr/share/hhvm/LICENSE/PHP
/usr/share/hhvm/LICENSE/ZEND
/usr/share/hhvm/LICENSE/curl
/usr/share/hhvm/LICENSE/libafdt
/usr/share/hhvm/LICENSE/libglog
/usr/share/hhvm/LICENSE/libmbfl
/usr/share/hhvm/LICENSE/lz4
/usr/share/hhvm/LICENSE/sqlite3
/usr/share/hhvm/LICENSE/timelib
%attr(775, hhvm, hhvm) %dir %{_localstatedir}/log/hhvm
%attr(775, hhvm, hhvm) %dir %{_localstatedir}/run/hhvm

%post -p /sbin/ldconfig
# Register the hhvm service
/usr/bin/systemctl preset hhvm.service >/dev/null 2>&1 ||:

# print site info
    cat <<BANNER
----------------------------------------------------------------------

Thanks for using ulyaoth-hhvm!

Please find the official documentation for hhvm here:
* http://hhvm.com/

For any additional help please visit my forum at:
* http://www.ulyaoth.net

----------------------------------------------------------------------
BANNER

%postun -p /sbin/ldconfig

%clean
%{__rm} -rf $RPM_BUILD_ROOT

%changelog
* Sun Jul 13 2014 Sjir Bagmeijer <sbagmeijer@ulyaoth.co.kr> 3.1.0-1
 - Release 3.1.0