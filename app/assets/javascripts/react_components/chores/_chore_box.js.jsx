var ChoreBox = React.createClass({
  getInitialState: function () {
    return JSON.parse(this.props.presenter);
  },

  handleChoreSubmit: function ( formData, action ) {
    $.ajax({
      data: formData,
      url: action,
      type: "POST",
      dataType: "json",
      success: function ( data ) {
        this.setState({ chores: data });
      }.bind(this)
    });
  },

  render: function () {
    return (
      <div className="chore-box">
      <div className="row">
        <div className="large-3 columns"><br /></div>
        <div className="large-6 columns">
        <h1>House Chore </h1>
        <ChoreList chores={ this.state.chores } />
        <ChoreForm form={ this.state.form } onChoreSubmit={ this.handleChoreSubmit } />
        </div>
        <div className="large-3 columns"><br /></div>
      </div>

      </div>
    );
  }
});
