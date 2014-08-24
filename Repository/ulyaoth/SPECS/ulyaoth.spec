Summary: Contains the repository file and GPG Key for the Ulyaoth Repository.
Name: ulyaoth
Version: 1.0.0
Release: 1%{?dist}
URL: http://ulyaoth.net/
Packager: Sjir Bagmeijer <sbagmeijer@ulyaoth.co.kr>

Source0: RPM-GPG-KEY-ulyaoth

%if 0%{?rhel}  == 6
Source1: ulyaoth-rhel.repo
%endif

%if 0%{?rhel}  == 7
Source1: ulyaoth-rhel.repo
%endif

%if 0%{?fedora} == 19
Source1: ulyaoth-fedora.repo
%endif

%if 0%{?fedora} == 20
Source1: ulyaoth-fedora.repo
%endif

License:        GPLv3

%description
Ulyaoth repository.

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
* Sun Aug 24 2014 Sjir Bagmeijer <sbagmeijer@ulyaoth.co.kr> 1.0.0-1
- Creating initial release.