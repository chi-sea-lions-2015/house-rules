var ItemList = React.createClass({
  render: function () {
    var itemNodes = this.props.items.map(function ( item ) {
      return <Item item={ item } key={ item.id } promise={"I buy"} />
    });

    return (
      <div className="item-list row">
        { itemNodes }
      </div>
    )
  }
});