var ChoreList = React.createClass({
  render: function () {
    var choreNodes = this.props.chores.map(function ( chore ) {
      return <Chore chore={ chore } key={ chore.id } />
    });

    return (
      <div className="chore-list row">
        { choreNodes }
      </div>
    )
  }
});
