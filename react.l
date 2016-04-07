(symbols 'react 'pico)

####
# load dependencies
#
# just call 'react~loadDeps' somewhere in your app start-up code
(de loadDeps ()
  (mapc 
    '((JS) 
      (queue '*JS 
        (pack "https://cdnjs.cloudflare.com/ajax/libs/" JS) ) )
    (quote 
      "react/0.14.8/react.min.js"
      "react/0.14.8/react-dom.min.js"
      "babel-core/5.8.23/browser.min.js"
      "jquery/2.2.0/jquery.min.js" ) ) )

####
# gotta have JSX!
# 
# babel knows what to do with it...
(de jsx (JS . @)
   (when *JS
      (when JS
         (prinl "<script type=\"text/babel\" src=\"" (srcUrl JS) "\"></script>") )
      (when (rest)
         (prinl "<script type=\"text/babel\">" @ "</script>") ) ) )


####
# FIXME: this is a giant disaster. Not to be used yet. 
# 
# react~createClass
# 
# a PL wrapper for React.createClass
#
# The call,
###
#
# (react~createClass 'Hello
#    (render
#       "return <h1>Hello, react.</h1>;" ) )
#
###
# returns the following JS(X):
###
#
# var Hello = React.createClass({
#   render: 
#     function() {
#       return <p>Hello, react.</p>; 
#     }
#   });
#
###
# ...only not as nice looking because I'm lazy.
# You can think of it as already kinda minimized for
# your production system. Heh
# 
# To be used with the built-in PicoLisp function 'out':
###
#
# (out "hello-react-generated.js"
#    (react~createClass 'Hello
#       ... ) )
#
###
# Now your JS lives in a '.js' file, ready for use in your PL apps.
###
#
# (html 0 "React Test" "@lib.css" NIL
#    ...
#    (javascript "hello-react-generated.js")
#    ... )
#
###
# 
# For a slightly more interesting example, check out... TODO.

(de createClass (Nm . Prg)
  (prin "var " Nm " = ") (prin "React.createClass({")
  (prin 
    (glue ", "
      (make
        (for P Prg
          (link 
            (pack (car P) ": "
              (cond 
                # args
                ((pair (cadr P))    # args              # rest of your JS
                  (pack "function(" (glue " " (mapcar pack @)) ") {" (glue " " (cddr P))) )
                # no args
                (T       # rest of your JS
                  (pack "function() {" (glue " " (cdr P))) ) )
              "}") ) ) ) ) )
  (prin "}); ") )

####
# react~renderDOM
#
# a PL wrapper for ReactDOM.render

(de renderDOM Prg
  (prin "ReactDOM.render(")
  (prin (glue "," Prg))
  (prin ");") )

