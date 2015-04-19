var ItemBox = React.createClass({
  getInitialState: function () {
    return JSON.parse(this.props.presenter);
  },

  handleItemSubmit: function ( formData, action ) {
    $.ajax({
      data: formData,
      url: action,
      type: "POST",
      dataType: "json",
      success: function ( data ) {
        this.setState({ items: data });
      }.bind(this)
    });
  },

  render: function () {
    return (
      <div className="item-box">
      <div className="row">
        <div className="large-3 columns"><br /></div>
        <div className="large-6 columns">
        <h1>House Communal Items </h1>
        <ol>
        <ItemList items={ this.state.items } />
        </ol>
        <ItemForm form={ this.state.form } onItemSubmit={ this.handleItemSubmit } />
        </div>
        <div className="large-3 columns"><br /></div>
      </div>

      </div>
    );
  }
});
