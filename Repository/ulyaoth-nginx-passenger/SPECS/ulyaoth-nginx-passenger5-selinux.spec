%define package_name ulyaoth-nginx-passenger5

# distribution specific definitions
%define use_systemd (0%{?fedora} && 0%{?fedora} >= 18) || (0%{?rhel} && 0%{?rhel} >= 7)
# end of distribution specific definitions

Summary: SELinux policy for Ulyaoth-Nginx-Passenger5.
Name: ulyaoth-nginx-passenger5-selinux
Version: 1.0.0
Release: 1%{?dist}
BuildArch: x86_64
Vendor: Ulyaoth
URL: https://www.ulyaoth.net
Packager: Sjir Bagmeijer <sbagmeijer@ulyaoth.co.kr>
License: GNU General Public License (GPL)

Source0: ulyaoth-nginx-passenger5.pp

BuildRequires: selinux-policy-targeted
Requires(post): policycoreutils, %{package_name}
Requires(preun): policycoreutils, %{package_name}
Requires(postun): policycoreutils
Requires: ulyaoth-nginx-passenger5

Provides: ulyaoth-nginx-passenger5-selinux

%description
This package opens up SELinux so you can use the package ulyaoth-nginx-passenger5.

%install
install -p -m 644 -D %{SOURCE0} $RPM_BUILD_ROOT%{_datadir}/selinux/packages/%{package_name}/%{SOURCE0}

%clean
%{__rm} -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root)
%dir %{_datadir}/selinux/packages/%{package_name}
%{_datadir}/selinux/packages/%{package_name}/%{SOURCE0}

%pre

%post
if [ $1 -eq 1 ]; then
semanage fcontext -a -t passenger_tmp_t '/var/cache/nginx/passenger_temp(/.*)?' 2>/dev/null || :
restorecon -R /var/cache/nginx/passenger_temp || :
semanage fcontext -a -t passenger_exec_t '/etc/nginx/modules/passenger(/.*)?' 2>/dev/null || :
restorecon -R /etc/nginx/modules/passenger || :
semanage fcontext -a -t passenger_log_t '/var/log/passenger(/.*)?' 2>/dev/null || :
restorecon -R /var/log/passenger || :
semodule -i %{_datadir}/selinux/packages/%{package_name}/%{SOURCE0} 2>/dev/null || :
%if %{use_systemd}
    /usr/bin/systemctl restart nginx.service >/dev/null 2>&1 ||:
%else
    /etc/init.d/nginx restart
%endif
    # print site info
    cat <<BANNER
----------------------------------------------------------------------

Thanks for using ulyaoth-nginx-passenger5-selinux!

For any additional help please visit my forum at:
* https://www.ulyaoth.net

----------------------------------------------------------------------
BANNER
fi

%preun
if [ $1 -eq 0 ]; then
semanage fcontext -a -t passenger_tmp_t '/var/cache/nginx/passenger_temp(/.*)?' 2>/dev/null || :
restorecon -R /var/cache/nginx/passenger_temp || :
semanage fcontext -a -t passenger_exec_t '/etc/nginx/modules/passenger(/.*)?' 2>/dev/null || :
restorecon -R /etc/nginx/modules/passenger || :
semanage fcontext -a -t passenger_log_t '/var/log/passenger(/.*)?' 2>/dev/null || :
restorecon -R /var/log/passenger || :
semodule -r ulyaoth-nginx-passenger5 2>/dev/null || :
%if %use_systemd
    /usr/bin/systemctl --no-reload disable nginx.service >/dev/null 2>&1 ||:
    /usr/bin/systemctl stop nginx.service >/dev/null 2>&1 ||:
%else
    /sbin/service nginx stop > /dev/null 2>&1
    /sbin/chkconfig --del nginx
%endif
fi

%postun
if [ "$1" -ge "1" ] ; then # Upgrade
semanage fcontext -d -t passenger_tmp_t '/var/cache/nginx/passenger_temp(/.*)?' 2>/dev/null || :
semanage fcontext -d -t passenger_exec_t '/etc/nginx/modules/passenger(/.*)?' 2>/dev/null || :
semanage fcontext -d -t passenger_log_t '/var/log/passenger(/.*)?' 2>/dev/null || :
semodule -i %{_datadir}/selinux/packages/%{package_name}/%{SOURCE0} 2>/dev/null || :
fi

%changelog
* Fri Apr 3 2015 Sjir Bagmeijer <sbagmeijer@ulyaoth.co.kr> 1.0.0-1
- Initial release for fixing SELinux when using package ulyaoth-nginx-passenger5.