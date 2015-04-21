var ChoreForm = React.createClass({
  handleSubmit: function ( event ) {
    event.preventDefault();
    var task = this.refs.task.getDOMNode().value.trim();

    // validate
    if (!task) {
      return false;
    }

    // submit
    var formData = $( this.refs.form.getDOMNode() ).serialize();
    this.props.onChoreSubmit( formData, this.props.form.action );

    // reset form
    this.refs.task.getDOMNode().value = "";
  },
  render: function () {
    return (
      <form ref="form" className="chore-form" action={ this.props.form.action } acceptCharset="UTF-8" method="post" onSubmit={ this.handleSubmit }>
        <fieldset>
          <legend>Create a Chore</legend>
          <p><input type="hidden" name={ this.props.form.csrf_param } value={ this.props.form.csrf_token } /></p>
          <p><textarea ref="task" name="chore[task]" placeholder="What's your chore?" /></p>
          <p><button type="submit">Create Chore</button></p>
        </fieldset>
      </form>
    )
  }
});
