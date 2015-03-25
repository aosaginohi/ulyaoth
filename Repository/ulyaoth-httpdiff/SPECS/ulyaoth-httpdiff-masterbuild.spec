%define debug_package %{nil}

# end of distribution specific definitions

Summary:    Perform the same request against two HTTP servers and diff the results. For best results use in a terminal that supports ANSI escape sequences.
Name:       ulyaoth-httpdiff-masterbuild
Version:    20150325
Release:    1%{?dist}
BuildArch: x86_64
License:    GNU GENERAL PUBLIC LICENSE Version 2
Group:      Applications/Internet
URL:        https://github.com/jgrahamc/httpdiff
Vendor:     John Graham-Cumming
Packager:   Sjir Bagmeijer <sbagmeijer@ulyaoth.co.kr>
Source0:    httpdiff
BuildRoot:  %{_tmppath}/ulyaoth-httpdiff-masterbuild-%{version}-%{release}-root-%(%{__id_u} -n)

Provides: httpdiff
Provides: ulyaoth-httpdiff
Provides: ulyaoth-httpdiff-masterbuild

%description
Perform the same request against two HTTP servers and diff the results. For best results use in a terminal that supports ANSI escape sequences.

%prep

%build

%install
install -d -m 755 %{buildroot}/%{lforward_home}/
%{__mkdir} -p $RPM_BUILD_ROOT/opt/logstash-forwarder/ssl

   
%clean
%{__rm} -rf $RPM_BUILD_ROOT

%pre

%files
%defattr(-,root,root)
/usr/bin/httpdiff


%post
cat <<BANNER
----------------------------------------------------------------------

Thanks for using ulyaoth-httpdiff-masterbuild!

Please find the official documentation for httpdiff here:
* https://github.com/jgrahamc/httpdiff

For any additional help please visit my forum at:
* http://www.ulyaoth.net

----------------------------------------------------------------------
BANNER


%preun


%postun


%changelog
* Wed Mar 25 2015 Sjir Bagmeijer <sbagmeijer@ulyaoth.co.kr> 20150325-1
- Initial release for httpdiff.