var Chore = React.createClass({
  render: function () {
    return (
      <div>
      <li>{ this.props.chore.task }</li>
      </div>
    )
  }
});
