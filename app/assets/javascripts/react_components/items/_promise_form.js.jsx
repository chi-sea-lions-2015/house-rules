var PromiseForm = React.createClass({
  handleSubmit: function ( event ) {
    event.preventDefault();

    // submit
    var formData = $( this.refs.form.getDOMNode() ).serialize();
    this.props.onPromiseSubmit( formData, this.props.promise_form.action );

  },
  render: function () {
    return (

      <form ref="promise-form" className="promise-form" action={ this.props.promise_form.action } acceptCharset="UTF-8" method="post" onSubmit={ this.handleSubmit }>
        <p><input type="hidden" name={ this.props.promise_form.csrf_param } value={ this.props.promise_form.csrf_token } /></p>
        <p><button type="submit">I Promise to Buy</button></p>
      </form>
    )
  }
});
