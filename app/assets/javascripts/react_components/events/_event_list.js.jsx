var EventList = React.createClass({
  render: function () {
    var eventNodes = this.props.events.map(function ( event ) {
      return <Event event={ event } key={ event.id } />
    });

    return (
      <div className="event-list row">
        { eventNodes }
      </div>
    )
  }
});
