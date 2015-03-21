
%define __jar_repack %{nil}
%define debug_package %{nil}
%define solr_home /opt/solr
%define solr_group solr
%define solr_user solr

Summary:    Apache Solr
Name:       ulyaoth-solr5-examples
Version:    5.0.0
Release:    1%{?dist}
BuildArch: x86_64
License:    Apache License version 2
Group:      Applications/Internet
URL:        https://lucene.apache.org/solr/
Vendor:     Apache Software Foundation
Packager:   Sjir Bagmeijer <sbagmeijer@ulyaoth.co.kr>
Source0:    
Source1:    
BuildRoot:  %{_tmppath}/solr-%{version}-%{release}-root-%(%{__id_u} -n)

Provides: solr-examples
Provides: solr5-examples
Provides: ulyaoth-solr-examples
Provides: ulyaoth-solr5-examples

%description
Solr is highly reliable, scalable and fault tolerant, providing distributed indexing, replication and load-balanced querying, automated failover and recovery, centralized configuration and more.

%install


%{__mkdir} -p $RPM_BUILD_ROOT/var/solr/data/
%{__mkdir} -p $RPM_BUILD_ROOT/var/log/solr/

%clean
%{__rm} -rf $RPM_BUILD_ROOT

%pre
getent group %{solr_group} >/dev/null || groupadd -r %{solr_group}
getent passwd %{solr_user} >/dev/null || /usr/sbin/useradd --comment "Solr Daemon User" --shell /bin/bash -M -r -g %{solr_group} --home %{solr_home} %{solr_user}

%files
%defattr(-,%{solr_user},%{solr_group})
%{banana_home}/server/webapps/banana.war
%{banana_home}/server/contexts/banana-context.xml


%post
cat <<BANNER
----------------------------------------------------------------------

Thanks for using ulyaoth-solr5-examples!

Please find the official documentation for solr here:
* https://lucene.apache.org/solr/

For any additional help please visit my forum at:
* https://www.ulyaoth.net

----------------------------------------------------------------------
BANNER

%changelog
* Sat Mar 21 2015 Sjir Bagmeijer <sbagmeijer@ulyaoth.co.kr> 5.0.0-1
- Initial release.
