
%define __jar_repack %{nil}
%define debug_package %{nil}
%define solr_home /opt/solr
%define solr_group solr
%define solr_user solr

# distribution specific definitions
%define use_systemd (0%{?fedora} && 0%{?fedora} >= 18) || (0%{?rhel} && 0%{?rhel} >= 7)

%if 0%{?rhel}  == 6
Requires(pre): shadow-utils
Requires: initscripts >= 8.36
Requires(post): chkconfig
%endif

%if 0%{?rhel}  == 7
Requires(pre): shadow-utils
Requires: systemd
BuildRequires: systemd
%endif

%if 0%{?fedora} >= 18
Requires(pre): shadow-utils
Requires: systemd
BuildRequires: systemd
%endif

Summary:    Apache Solr
Name:       ulyaoth-solr5
Version:    5.0.0
Release:    1%{?dist}
BuildArch: x86_64
License:    Apache License version 2
Group:      Applications/Internet
URL:        https://lucene.apache.org/solr/
Vendor:     Apache Software Foundation
Packager:   Sjir Bagmeijer <sbagmeijer@ulyaoth.co.kr>
Source0:    solr-%{version}.tar.gz
Source1:    solr5-log4j.properties
Source2:    solr5-solr.init
Source3:    solr5-solr.service
BuildRoot:  %{_tmppath}/solr-%{version}-%{release}-root-%(%{__id_u} -n)

Provides: solr
Provides: solr5
Provides: ulyaoth-solr
Provides: ulyaoth-solr5

%description
Solr is highly reliable, scalable and fault tolerant, providing distributed indexing, replication and load-balanced querying, automated failover and recovery, centralized configuration and more.

%prep
%setup -q -n solr-%{version}

%build

%install
install -d -m 755 %{buildroot}/%{solr_home}/
cp -R * %{buildroot}/%{solr_home}/

%{__mkdir} -p $RPM_BUILD_ROOT/var/solr/data/
%{__mkdir} -p $RPM_BUILD_ROOT/var/log/solr/

cp -R %{buildroot}/%{solr_home}/bin/solr.in.sh $RPM_BUILD_ROOT/var/solr/
cp -R %{buildroot}/%{solr_home}/server/solr/solr.xml $RPM_BUILD_ROOT/var/solr/data/

%if %{use_systemd}
# install systemd-specific files
%{__mkdir} -p $RPM_BUILD_ROOT%{_unitdir}
%{__install} -m644 %SOURCE3 \
        $RPM_BUILD_ROOT%{_unitdir}/solr.service
%else
# install SYSV init stuff
%{__mkdir} -p $RPM_BUILD_ROOT%{_initrddir}
%{__install} -m755 %{SOURCE2} \
   $RPM_BUILD_ROOT%{_initrddir}/solr
%endif

%clean
%{__rm} -rf $RPM_BUILD_ROOT

%pre
getent group %{solr_group} >/dev/null || groupadd -r %{solr_group}
getent passwd %{solr_user} >/dev/null || /usr/sbin/useradd --comment "Solr Daemon User" --shell /bin/bash -M -r -g %{solr_group} --home %{solr_home} %{solr_user}

%files
%defattr(-,%{solr_user},%{solr_group})
%{solr_home}/*
%dir %{_localstatedir}/log/solr
%config(noreplace) %{solr_home}/server/contexts/solr-jetty-context.xml
%config(noreplace) %{solr_home}/opt/solr/server/etc/jetty-https-ssl.xml
%config(noreplace) %{solr_home}/opt/solr/server/etc/jetty.xml
%config(noreplace) %{solr_home}/opt/solr/server/etc/webdefault.xml
%config(noreplace) %{solr_home}/opt/solr/server/solr/solr.xml
%config(noreplace) %{solr_home}/opt/solr/server/solr/zoo.xml
%config(noreplace) %{_localstatedir}/solr/data/solr.xml

%defattr(-,root,root)
%config(noreplace) %{_sysconfdir}/logrotate.d/tomcat
%if %{use_systemd}
%{_unitdir}/tomcat.service
%else
%{_initrddir}/tomcat
%endif


%post
# Register the solr service
if [ $1 -eq 1 ]; then
%if %{use_systemd}
    /usr/bin/systemctl preset solr.service >/dev/null 2>&1 ||:
%else
    /sbin/chkconfig --add solr
%endif

cat <<BANNER
----------------------------------------------------------------------

Thanks for using ulyaoth-solr5!

Please find the official documentation for solr here:
* https://lucene.apache.org/solr/

For any additional help please visit my forum at:
* https://www.ulyaoth.net

----------------------------------------------------------------------
BANNER
fi

%preun
if [ $1 -eq 0 ]; then
%if %use_systemd
    /usr/bin/systemctl --no-reload disable solr.service >/dev/null 2>&1 ||:
    /usr/bin/systemctl stop solr.service >/dev/null 2>&1 ||:
%else
    /sbin/service solr stop > /dev/null 2>&1
    /sbin/chkconfig --del solr
%endif
fi

%postun
%if %use_systemd
/usr/bin/systemctl daemon-reload >/dev/null 2>&1 ||:
%endif
if [ $1 -ge 1 ]; then
    /sbin/service solr status  >/dev/null 2>&1 || exit 0
fi

%changelog
* Sat Mar 21 2015 Sjir Bagmeijer <sbagmeijer@ulyaoth.co.kr> 5.0.0-1
- Initial release.
