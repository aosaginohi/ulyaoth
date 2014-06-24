
default:	build

clean:
	rm -rf Makefile objs

build:
	$(MAKE) -f objs/Makefile
	$(MAKE) -f objs/Makefile manpage

install:
	$(MAKE) -f objs/Makefile install

upgrade:
	/usr/sbin/nginx -t

	kill -USR2 `cat /var/run/nginx.pid`
	sleep 1
	test -f /var/run/nginx.pid.oldbin

	kill -QUIT `cat /var/run/nginx.pid.oldbin`
