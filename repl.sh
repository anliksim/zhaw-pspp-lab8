docker run --rm -it -v \
 /home/anliksim/codebase/zhaw-pspp-lab8:/usr/local/share/common-lisp/source \
 -w /usr/local/share/common-lisp/source \
 daewok/lisp-devel:base sbcl