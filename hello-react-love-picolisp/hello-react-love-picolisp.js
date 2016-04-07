var Hello = React.createClass({

  getInitialState: function() {
    return { message: '' };
  },

  componentDidMount: function() {
    $.get(
      this.props.url, 
      function(msg) {
        this.setState({ message: msg });
      }.bind(this)
    );
  },

  render: function() {
    return <h1>{this.state.message}</h1>;
  }

});


ReactDOM.render(
  <Hello url='!getMessage' />,
  document.getElementById('hello')
);
