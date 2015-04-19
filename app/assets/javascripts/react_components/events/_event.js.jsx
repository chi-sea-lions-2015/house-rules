var Event = React.createClass({
  render: function () {
    return (
      <div>
        <li><p>{ this.props.event.name }<br/>{ this.props.event.description }<br/>{ this.props.event.date }</p></li>
      </div>
    )
  }
});
