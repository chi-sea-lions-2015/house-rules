var IssueForm = React.createClass({
  handleSubmit: function ( event ) {
    event.preventDefault();
    var reason = this.refs.reason.getDOMNode().value.trim();

    // validate
    if (!reason) {
      return false;
    }

    // submit
    var formData = $( this.refs.form.getDOMNode() ).serialize();
    this.props.onIssueSubmit( formData, this.props.form.action );

    // reset form
    this.refs.reason.getDOMNode().value = "";
  },
  render: function () {
    return (


      <form ref="form" className="issue-form" action={ this.props.form.action } acceptCharset="UTF-8" method="post" onSubmit={ this.handleSubmit }>
        <p><input type="hidden" name={ this.props.form.csrf_param } value={ this.props.form.csrf_token } /></p>
        <p><textarea ref="reason" name="issue[reason]" placeholder="What's your reason?" /></p>
          <p><button type="submit">Issue this Rule</button></p>
      </form>
    )
  }
});
