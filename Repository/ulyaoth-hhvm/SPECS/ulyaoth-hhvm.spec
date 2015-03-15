#
%define debug_package %{nil}
%define hhvm_home %{_sysconfdir}/hhvm
%define hhvm_user hhvm
%define hhvm_group hhvm

Summary: HHVM virtual machine, runtime, and JIT for the PHP language
Name: ulyaoth-hhvm
Version: 3.6.1
Release: 1%{?dist}
BuildArch: x86_64
Group: Applications/Internet
URL: http://www.hhvm.com/
Vendor: Facebook.
Packager: Sjir Bagmeijer <sbagmeijer@ulyaoth.co.kr>

Source0: hhvm-%{version}.tar.gz
Source1: php.ini
Source2: config.hdf
Source3: server.hdf
Source4: hhvm.service
Source5: static.mime-types.hdf

License: GPL

%if 0%{?fedora} >= 18
BuildRequires: libsq3-devel
%endif

Requires: boost
Requires: boost-jam
Requires: boost-build
Requires: glog

BuildRoot: %{_tmppath}/hhvm-%{version}
BuildRequires: libzip-devel
BuildRequires: double-conversion-devel
BuildRequires: lz4-devel
BuildRequires: libc-client-devel
BuildRequires: jemalloc-devel
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
BuildRequires: boost-jam
BuildRequires: boost-build
BuildRequires: bzip2-devel
BuildRequires: curl-devel
BuildRequires: expat-devel
BuildRequires: elfutils-libelf-devel
BuildRequires: gd-devel
BuildRequires: glog-devel
BuildRequires: ImageMagick-devel
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
BuildRequires: glibc-devel
BuildRequires: libnotify-devel
BuildRequires: unixODBC-devel
BuildRequires: libvpx-devel
BuildRequires: openssl-devel


Provides: hhvm
Provides: ulyaoth-hhvm

%description 
HHVM is an open-source virtual machine designed for executing programs written in Hack and PHP. HHVM uses a just-in-time (JIT) compilation approach to achieve superior performance while maintaining the development flexibility that PHP provides.

%prep
%setup -q -n hhvm-%{version}

%build
%{__rm} -rf $RPM_BUILD_ROOT 
export CMAKE_PREFIX_PATH=$RPM_BUILD_ROOT%{_prefix}
cmake . -DCMAKE_INSTALL_PREFIX=$RPM_BUILD_ROOT%{_prefix} -DMYSQL_UNIX_SOCK_ADDR=/var/lib/mysql/mysql.sock
make

%install
%{__make} install

%{__mkdir} -p $RPM_BUILD_ROOT%{_localstatedir}/log/hhvm
%{__mkdir} -p $RPM_BUILD_ROOT%{_localstatedir}/run/hhvm
%{__mkdir} -p $RPM_BUILD_ROOT%{_sysconfdir}/hhvm
%{__mkdir} -p $RPM_BUILD_ROOT%{_unitdir}
%{__mkdir} -p $RPM_BUILD_ROOT/usr/share/hhvm/hdf
%{__install} -m 644 -p %{SOURCE1} \
   $RPM_BUILD_ROOT%{_sysconfdir}/hhvm/php.ini
%{__install} -m 644 -p %{SOURCE2} \
   $RPM_BUILD_ROOT%{_sysconfdir}/hhvm/config.hdf
%{__install} -m 644 -p %{SOURCE3} \
   $RPM_BUILD_ROOT%{_sysconfdir}/hhvm/server.hdf
%{__install} -m 644 -p %{SOURCE4} \
   $RPM_BUILD_ROOT%{_unitdir}/hhvm.service
%{__install} -m 644 -p %{SOURCE5} \
   $RPM_BUILD_ROOT%{_datadir}/hhvm/hdf/static.mime-types.hdf  

%{__rm} -rf $RPM_BUILD_ROOT/usr/lib/libzip.a
%{__rm} -rf $RPM_BUILD_ROOT/usr/lib/libzip.so
%{__rm} -rf $RPM_BUILD_ROOT/usr/include
%{__rm} -rf $RPM_BUILD_ROOT/usr/lib64
%{__rm} -rf $RPM_BUILD_ROOT/usr/man/
%{__rm} -rf $RPM_BUILD_ROOT/usr/share/doc/
%{__rm} -rf $RPM_BUILD_ROOT/usr/lib/libpcre.a
%{__rm} -rf $RPM_BUILD_ROOT/usr/lib/libpcreposix.a
%{__rm} -rf $RPM_BUILD_ROOT/usr/lib/libpcrecpp.a
%{__rm} -rf $RPM_BUILD_ROOT/usr/bin/pcregrep
%{__rm} -rf $RPM_BUILD_ROOT/usr/bin/pcretest
%{__rm} -rf $RPM_BUILD_ROOT/usr/bin/pcrecpp_unittest
%{__rm} -rf $RPM_BUILD_ROOT/usr/bin/pcre_scanner_unittest
%{__rm} -rf $RPM_BUILD_ROOT/usr/bin/pcre_stringpiece_unittest
%{__rm} -rf $RPM_BUILD_ROOT/usr/bin/hphpize




%files
%defattr(-,root,root,-)
/usr/bin/hhvm
/usr/bin/hhvm-gdb
/usr/bin/hh_server
/usr/bin/hh_client
%dir /etc/hhvm
%config(noreplace) /etc/hhvm/config.hdf
%config(noreplace) /etc/hhvm/php.ini
%config(noreplace) /etc/hhvm/server.hdf
%{_unitdir}/hhvm.service
%dir /usr/share/hhvm
%dir /usr/share/hhvm/hdf
%config /usr/share/hhvm/hdf/static.mime-types.hdf
%dir /var/log/hhvm
%dir /var/run/hhvm
%attr(775, hhvm, hhvm) /var/log/hhvm
%attr(775, hhvm, hhvm) /var/run/hhvm

   
%clean
%{__rm} -rf $RPM_BUILD_ROOT


%pre
getent group %{hhvm_group} >/dev/null || groupadd -r %{hhvm_group}
getent passwd %{hhvm_user} >/dev/null || \
    useradd -r -g %{hhvm_group} -s /sbin/nologin \
    -d %{hhvm_home} -c "hhvm user"  %{hhvm_user}
exit 0

%post
# Register the hhvm service
/usr/bin/systemctl preset hhvm.service >/dev/null 2>&1 ||:

# print site info
    cat <<BANNER
----------------------------------------------------------------------

Thanks for using ulyaoth-hhvm!

Please find the official documentation for hhvm here:
* http://www.hhvm.com/

For any additional help please visit my forum at:
* http://www.ulyaoth.net

----------------------------------------------------------------------
BANNER

%postun
/usr/bin/systemctl daemon-reload >/dev/null 2>&1 ||:

%changelog
* Sun Mar 15 2015 Sjir Bagmeijer <sbagmeijer@ulyaoth.co.kr> 3.6.1-1
- Updated to HHVM 3.6.1.

* Wed Mar 11 2015 Sjir Bagmeijer <sbagmeijer@ulyaoth.co.kr> 3.5.2-2
- Added support for Fedora 22 and CentOS 6 & 7.
- Added i386 support.
- Cleaned spec file slightly.

* Sat Feb 21 2015 Sjir Bagmeijer <sbagmeijer@ulyaoth.co.kr> 3.5.2-1
- Updated to version HHVM 3.5.2.

* Sat Oct 11 2014 Sjir Bagmeijer <sbagmeijer@ulyaoth.co.kr> 3.3.1-1
- Updated to version 3.3.1.
- Support for Fedora 21.

* Sat Sep 20 2014 Sjir Bagmeijer <sbagmeijer@ulyaoth.co.kr> 3.3.0-1
- Updated to HHVM 3.3.0.

* Wed Aug 27 2014 Sjir Bagmeijer <sbagmeijer@ulyaoth.co.kr> 3.2.0-1
 - Release 3.2.0
 - Fixes for RHEL

* Sun Jul 13 2014 Sjir Bagmeijer <sbagmeijer@ulyaoth.co.kr> 3.1.1-1
 - Initial Spec file release
 - Release 3.1.1
