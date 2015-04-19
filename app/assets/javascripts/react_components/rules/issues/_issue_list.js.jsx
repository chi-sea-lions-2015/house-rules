var IssueList = React.createClass({
  render: function () {
    // debugger;
    var usersNodes = this.props.users
    var issueNodes = this.props.issues.map(function ( issue ) {
      var user = undefined;
      var something = usersNodes.map(function( u ){
        
        if (issue.user_id == u.id) {
          user = u;
        }
      });
      
      return <Issue issue={ issue } key={ issue.id } user={ user }/>
    });

    return (
      <div className="issue-list row">
        { issueNodes }
      </div>
    )
  }
});
