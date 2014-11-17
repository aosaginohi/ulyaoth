
%define __jar_repack %{nil}
%define tomcat_home /opt/tomcat
%define tomcat_group tomcat
%define tomcat_user tomcat

Summary:    Apache Servlet/JSP Engine
Name:       ulyaoth-tomcat6-admin
Version:    6.0.41
Release:    1%{?dist}
License:    Apache License version 2
Group:      Applications/Internet
URL:        http://tomcat.apache.org/
Vendor:     Apache Software Foundation
Packager:   Sjir Bagmeijer <sbagmeijer@ulyaoth.co.kr>
Source0:    apache-tomcat-%{version}.tar.gz
BuildRoot:  %{_tmppath}/tomcat-%{version}-%{release}-root-%(%{__id_u} -n)

Requires: ulyaoth-tomcat6

Provides: tomcat-admin
Provides: apache-tomcat-admin
Provides: ulyaoth-tomcat-admin
Provides: ulyaoth-tomcat6-admin

%description
Apache Tomcat is an open source software implementation of the Java Servlet and JavaServer Pages technologies. The Java Servlet and JavaServer Pages specifications are developed under the Java Community Process.

Apache Tomcat is developed in an open and participatory environment and released under the Apache License version 2. Apache Tomcat is intended to be a collaboration of the best-of-breed developers from around the world. We invite you to participate in this open development project. To learn more about getting involved, click here.

Apache Tomcat powers numerous large-scale, mission-critical web applications across a diverse range of industries and organizations. Some of these users and their stories are listed on the PoweredBy wiki page.

Apache Tomcat, Tomcat, Apache, the Apache feather, and the Apache Tomcat project logo are trademarks of the Apache Software Foundation.

%prep
%setup -q -n apache-tomcat-%{version}

%build

%install
install -d -m 755 %{buildroot}/%{tomcat_home}/
cp -R * %{buildroot}/%{tomcat_home}/

# Delete all files except webapp admin
%{__rm} -rf %{tomcat_home}/bin
%{__rm} -rf %{tomcat_home}/conf
%{__rm} -rf %{tomcat_home}/lib
%{__rm} -rf %{tomcat_home}/LICENSE
%{__rm} -rf %{tomcat_home}/NOTICE
%{__rm} -rf %{tomcat_home}/RELEASE-NOTES
%{__rm} -rf %{tomcat_home}/RUNNING.txt
%{__rm} -rf %{tomcat_home}/temp
%{__rm} -rf %{tomcat_home}/work
%{__rm} -rf %{tomcat_home}/webapps/docs
%{__rm} -rf %{tomcat_home}/webapps/examples
%{__rm} -rf %{tomcat_home}/webapps/ROOT

%clean
%{__rm} -rf $RPM_BUILD_ROOT

%files
%defattr(-,%{tomcat_user},%{tomcat_group})
%{tomcat_home}/*
%dir %{_localstatedir}/log/tomcat

%defattr(-,root,root)
%config(noreplace) %{_sysconfdir}/logrotate.d/tomcat
%if %{use_systemd}
%{_unitdir}/tomcat.service
%else
%{_initrddir}/tomcat
%endif


%post
cat <<BANNER
----------------------------------------------------------------------

Thanks for using ulyaoth-tomcat6-admin!

Please find the official documentation for tomcat here:
* http://tomcat.apache.org/

For any additional help please visit my forum at:
* http://www.ulyaoth.net

----------------------------------------------------------------------
BANNER
fi

%changelog
* Mon Nov 17 2014 Sjir Bagmeijer <sbagmeijer@ulyaoth.co.kr> 6.0.41-1
- Creating separate package for the admin interface.