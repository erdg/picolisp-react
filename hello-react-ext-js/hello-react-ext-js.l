(load "@lib/http.l" "@lib/xhtml.l" "@lib/form.l")
(load "../react.l")
(react~loadDeps)

(de work ()
   (html 0 "Hello React" "@lib.css" NIL
      (<div> '(id . "hello") NIL)
      (javascript "hello-react.js") ) )

(de go () (server 8080 "!work"))
