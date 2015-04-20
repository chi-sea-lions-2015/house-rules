var Item = React.createClass({
  render: function () {
    return (
      <div>
        <li><p>{ this.props.item.name }<br/>Brand: { this.props.item.brand }<br/>Quantity: { this.props.item.quantity }<br/>{ this.props.item.stock_level }<br/>
        <PromiseBox />
        </p></li>
      </div>
    )
  }
});