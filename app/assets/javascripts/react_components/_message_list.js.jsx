var MessageList = React.createClass({
  render: function () {
    var messageNodes = this.props.messages.map(function ( message ) {
      return <Message content={ message.content } key={ message.id } />
    });

    return (
      <div className="message-list">
        { messageNodes }
      </div>
    )
  }
});
