var ItemForm = React.createClass({
  handleSubmit: function ( e ) {
    e.preventDefault();
    var name = this.refs.name.getDOMNode().value.trim();
    var brand = this.refs.brand.getDOMNode().value.trim();
    var quantity = this.refs.quantity.getDOMNode().value.trim();
    var stock_level = this.refs.stock_level.getDOMNode().value.trim();

    // validate
    if (!name) {
      return false;
    }
    if (!stock_level) {
      return false;
    }

    // submit
    var formData = $( this.refs.form.getDOMNode() ).serialize();
    this.props.onItemSubmit( formData, this.props.form.action );

    // reset form
    this.refs.name.getDOMNode().value = "";
    this.refs.brand.getDOMNode().value = "";
    this.refs.quantity.getDOMNode().value = "";
    this.refs.stock_level.getDOMNode().value = "";
  },
  render: function () {
    return (
      <form ref="form" className="item-form" action={ this.props.form.action } acceptCharset="UTF-8" method="post" onSubmit={ this.handleSubmit }>
        <fieldset>
          <legend>Create a Communal Item</legend>
          <p><input type="hidden" name={ this.props.form.csrf_param } value={ this.props.form.csrf_token } /></p>
          <p><input type="text" ref="name" name="communal_item[name]" placeholder="What's the communal item?" /></p>
          <p><input type="text" ref="brand" brand="communal_item[brand]" placeholder="What's the brand?" /></p>
          <p><input type="text" ref="quantity" quantity="communal_item[quantity]" placeholder="How many?" /></p>
          <p><textarea ref="stock_level" name="communal_item[stock_level]" placeholder="What's the stock status now?" /></p>
          <button type="submit">Create Event</button>
        </fieldset>
      </form>
    )
  }
});
