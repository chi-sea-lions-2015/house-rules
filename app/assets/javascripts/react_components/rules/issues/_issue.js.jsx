var Issue = React.createClass({
  render: function () {
    return (
      <div>

      <p>@{this.props.user.first_name}: { this.props.issue.reason }</p>
      
      </div>
    )
  }
});