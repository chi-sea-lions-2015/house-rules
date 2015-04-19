var IssueBox = React.createClass({
  getInitialState: function () {
    // debugger;
    return JSON.parse(this.props.issue_presenter);
  },

  handleIssueSubmit: function ( formData, action ) {
    $.ajax({
      data: formData,
      url: action,
      type: "POST",
      dataType: "json",
      success: function ( data ) {
        this.setState({ issues: data });
      }.bind(this)
    });
  },

  render: function () {
    // debugger;
    return (
      <div className="issue-box">
      <div className="row">
        <div className="large-3 columns"><br /></div>
        <div className="large-6 columns">
        <h1>Rule Issues </h1>
        <IssueList issues={ this.state.issues } users={ this.state.users } />
        <IssueForm form={ this.state.form } onIssueSubmit={ this.handleIssueSubmit } />
        </div>
        <div className="large-3 columns"><br /></div>
      </div>

      </div>
    );
  }
});
