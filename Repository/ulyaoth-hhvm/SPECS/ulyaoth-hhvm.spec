#
%define hhvm_home %{_sysconfdir}/hhvm
%define hhvm_user hhvm
%define hhvm_group hhvm

Summary: HHVM virtual machine, runtime, and JIT for the PHP language
Name: ulyaoth-hhvm
Version: 3.1.1
Release: 1%{?dist}
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

Requires: boost
Requires: boost-jam
Requires: boost-build
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
BuildRequires: boost-jam
BuildRequires: boost-build
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
BuildRequires: glibc-devel
BuildRequires: libnotify-devel
BuildRequires: unixODBC-devel
BuildRequires: libzip-devel
BuildRequires: lz4-devel
BuildRequires: libsq3-devel
BuildRequires: double-conversion-devel

Provides: hhvm
Provides: ulyaoth-hhvm

%description 
HHVM is an open-source virtual machine designed for executing programs written in Hack and PHP. HHVM uses a just-in-time (JIT) compilation approach to achieve superior performance while maintaining the development flexibility that PHP provides.

%prep
%setup -q -n hhvm-%{version}

%build 
export CMAKE_PREFIX_PATH=$RPM_BUILD_ROOT%{_prefix}
cmake . -DCMAKE_INSTALL_PREFIX=$RPM_BUILD_ROOT%{_prefix}
make

%install
make install

%{__mkdir} -p $RPM_BUILD_ROOT%{_localstatedir}/log/hhvm
%{__mkdir} -p $RPM_BUILD_ROOT%{_localstatedir}/run/hhvm
%{__mkdir} -p $RPM_BUILD_ROOT%{_sysconfdir}/hhvm
%{__mkdir} -p $RPM_BUILD_ROOT/usr/bin
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
%{__install} -m 755 -p %_builddir/hhvm-%{version}/hphp/hhvm/hhvm \
        $RPM_BUILD_ROOT/usr/bin/hhvm  
%{__install} -m 644 -p %_builddir/hhvm-%{version}/hphp/doc/mime.hdf \
        $RPM_BUILD_ROOT/usr/share/hhvm/hdf/mime.hdf

%clean
%{__rm} -rf $RPM_BUILD_ROOT
    
%files
/usr/bin/hhvm
%defattr(-,root,root,-)
%dir %{_sysconfdir}/hhvm
%config(noreplace) %{_sysconfdir}/hhvm/config.hdf
%config(noreplace) %{_sysconfdir}/hhvm/php.ini
%config(noreplace) %{_sysconfdir}/hhvm/server.hdf
%dir /usr/share/hhvm
%dir /usr/share/hhvm/hdf
%config /usr/share/hhvm/hdf/mime.hdf
%attr(775, hhvm, hhvm) %dir %{_localstatedir}/log/hhvm
%attr(775, hhvm, hhvm) %dir %{_localstatedir}/run/hhvm
%{_unitdir}/hhvm.service

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
* http://hhvm.com/

For any additional help please visit my forum at:
* http://www.ulyaoth.net

----------------------------------------------------------------------
BANNER

%postun
/usr/bin/systemctl daemon-reload >/dev/null 2>&1 ||:

%changelog
* Sun Jul 13 2014 Sjir Bagmeijer <sbagmeijer@ulyaoth.co.kr> 3.1.1-1
 - Initial Spec file release
 - Release 3.1.1
