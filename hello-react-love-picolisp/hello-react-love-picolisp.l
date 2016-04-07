(load "@lib/http.l" "@lib/xhtml.l" "@lib/form.l")
(load "../react.l")
(react~loadDeps)

(de getMessage ()
   (httpHead "text/plain; charset=utf-8")
   (ht:Out T
      (prin "Hello, react! Love, PicoLisp.") ) )

(de hello ()
   (html 0 "Hello React" "@lib.css" NIL
      (<div> '(id . "hello") NIL)
      (react~jsx "hello-react-love-picolisp.js" ) ) )

(de go () (server 8080 "!hello"))
