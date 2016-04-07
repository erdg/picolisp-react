(load "@lib/http.l" "@lib/xhtml.l" "@lib/form.l")
(load "../react.l")
(react~loadDeps)

(de work ()
   (html 0 "Hello React" "@lib.css" NIL
      (<div> '(id . "hello") NIL)
      (javascript NIL 
         "var HelloReact = React.createClass({
            render: function() {
               return React.createElement('h1', null, 'Hello, react!');
            }
         });

         var HelloReactFactory = React.createFactory(HelloReact);

         ReactDOM.render(
            HelloReactFactory(),
            document.getElementById('hello')
         );" ) ) )

(de go () (server 8080 "!work"))

