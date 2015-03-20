
%define __jar_repack %{nil}
%define debug_package %{nil}
%define banana_home /opt/solr
%define banana_group solr
%define banana_user solr

Summary:    Banana UI
Name:       ulyaoth-banana
Version:    1.5.0
Release:    1%{?dist}
BuildArch: x86_64
License:    Apache License version 2
Group:      Applications/Internet
URL:        https://github.com/LucidWorks/banana/
Vendor:     Apache Software Foundation
Packager:   Sjir Bagmeijer <sbagmeijer@ulyaoth.co.kr>
Source0:    banana.war
Source1:    banana-context.xml
BuildRoot:  %{_tmppath}/banana-%{version}-%{release}-root-%(%{__id_u} -n)

Provides: banana
Provides: ulyaoth-banana

%description
Banana is a tool to create dashboards to visualize data you have stored in Solr. Commonly used with Logstash for log data, any content stored in a Solr index is eligible for visualization in a Banana dashboard.

%install
install -d -m 755 %{buildroot}/%{banana_home}/
%{__install} -m644 %SOURCE0 \
        $RPM_BUILD_ROOT/%{banana_home}/server/webapps/banana.war

%{__mkdir} -p $RPM_BUILD_ROOT/opt/solr/server/contexts
%{__install} -m644 %SOURCE1 \
        $RPM_BUILD_ROOT/opt/solr/server/contexts/banana-context.xml

%clean
%{__rm} -rf $RPM_BUILD_ROOT


%files
%defattr(-,%{solr_user},%{solr_group})
%{banana_home}/server/webapps/banana.war
%{banana_home}/server/contexts/banana-context.xml


%post
cat <<BANNER
----------------------------------------------------------------------

Thanks for using ulyaoth-banana!

Please find the official documentation for Banana here:
* https://github.com/LucidWorks/banana/

For any additional help please visit my forum at:
* https://www.ulyaoth.net

----------------------------------------------------------------------
BANNER
fi

%changelog
* Fri Mar 20 2015 Sjir Bagmeijer <sbagmeijer@ulyaoth.co.kr> 1.5.0-1
- Initial release for Banana based on version 1.5.0.
