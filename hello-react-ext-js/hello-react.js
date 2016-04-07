var HelloReact = React.createClass({
  render: function() {
    return React.createElement('h1', null, 'Hello, react!');
  }
});

var HelloReactFactory = React.createFactory(HelloReact);

ReactDOM.render(
  HelloReactFactory(),
    document.getElementById('hello')
);
