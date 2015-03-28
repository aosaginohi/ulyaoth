Summary: Contains the repository file and GPG Key for the Ulyaoth Repository.
Name: ulyaoth
Version: 1.0.3
Release: 1%{?dist}
BuildArch: x86_64
URL: https://community.ulyaoth.net/
Packager: Sjir Bagmeijer <sbagmeijer@ulyaoth.co.kr>

Source0: RPM-GPG-KEY-ulyaoth
Source1: ulyaoth.repo

License:        GPLv3

%description
Ulyaoth repository.

%prep
%setup -q

%build

%install

%{__mkdir} -p  $RPM_BUILD_ROOT%{_sysconfdir}/pki/rpm-gpg/
%{__mkdir} -p $RPM_BUILD_ROOT%{_sysconfdir}/yum.repos.d/

%{__install} -m 644 -p %{SOURCE0} \
   $RPM_BUILD_ROOT%{_sysconfdir}/pki/rpm-gpg/RPM-GPG-KEY-ulyaoth
%{__install} -m 644 -p %{SOURCE1} \
   $RPM_BUILD_ROOT%{_sysconfdir}/yum.repos.d/ulyaoth.repo

%clean
rm -rf $RPM_BUILD_ROOT


%files
%defattr(-,root,root,-)
%config %{_sysconfdir}/pki/rpm-gpg/RPM-GPG-KEY-ulyaoth
%config %{_sysconfdir}/yum.repos.d/ulyaoth.repo

%post
    cat <<BANNER
----------------------------------------------------------------------

Thanks for using the Ulyaoth repository!

For any additional information or help please visit my forum at:
* http://www.ulyaoth.net

----------------------------------------------------------------------
BANNER


%changelog
* Sat Mar 28 2015 Sjir Bagmeijer <sbagmeijer@ulyaoth.co.kr> 1.0.3-1
- Updating public GPG key to a new 4096 bits one.

* Fri Mar 13 2015 Sjir Bagmeijer <sbagmeijer@ulyaoth.co.kr> 1.0.2-1
- Support for Oracle Linux 6 and 7.

* Wed Mar 11 2015 Sjir Bagmeijer <sbagmeijer@ulyaoth.co.kr> 1.0.1-2
- Small fix to make spec file more clean.
- i386 Support.

* Wed Mar 11 2015 Sjir Bagmeijer <sbagmeijer@ulyaoth.co.kr> 1.0.1-1
- Support for CentOS 6, 7 and Fedora 22.

* Sat Oct 4 2014 Sjir Bagmeijer <sbagmeijer@ulyaoth.co.kr> 1.0.0-1
- Support for Fedora 21.

* Sun Aug 24 2014 Sjir Bagmeijer <sbagmeijer@ulyaoth.co.kr> 1.0.0-1
- Creating initial release.
