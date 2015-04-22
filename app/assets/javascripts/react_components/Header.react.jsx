var ReactPropTypes = React.PropTypes;
// var SessionActionCreators = require('../actions/SessionActionCreators.react.jsx');

var Menu = React.createClass({

  getInitialState: function() {
    return {
      visible: false
    };
  },

  show: function() {
    this.setState({ visible: true });
    document.addEventListener("click", this.hide.bind(this));
  },

  hide: function() {
    document.removeEventListener("click", this.hide.bind(this));
    this.setState({ visible: false });
  },

  render: function() {
    return <div className="menu">
      <div className={(this.state.visible ? "menu-visible " : "") + "menu-" + this.props.alignment}>{this.props.children}</div>
    </div>;
  }
});

var MenuItem = React.createClass({
  navigate: function(hash) {
    window.location = hash;
  },
  render: function() {
    return <div className="menu-item" onClick={this.navigate.bind(this, this.props.hash)}>{this.props.children}</div>;
  }
});

var Header = React.createClass({

  propTypes: {
    isLoggedIn: ReactPropTypes.bool,
    email: ReactPropTypes.string,
    houseName: ReactPropTypes.string,
    houseID: ReactPropTypes.integer,
    userID: ReactPropTypes.integer
  },

  logout: function(e) {
    e.preventDefault();
  },

  showLeft: function() {
    this.refs.left.show();
  },

  hideLeft: function() {
    this.refs.left.hide();
  },

  render: function() {
    var rightNav = this.props.isLoggedIn ? (
      <ul className="right">
        <li className="has-dropdown">
          <a href="#">{this.props.email}</a>
          <ul className="dropdown">
            <li><a href='/logout'>Logout</a></li>
          </ul>
        </li>
      </ul>
    ) : (
      <ul className="right">
        <li><a href="/login">Login</a></li>
        <li><a href="/signup">Sign up</a></li>
      </ul>
    );

    var leftNav = this.props.isLoggedIn ? (
      <ul className="left">
        <div>
          <button className="menu-button" onMouseOver={this.showLeft}>{this.props.houseName}</button>

          <Menu ref="left" alignment="left">
            <MenuItem hash={"/houses/"+this.props.houseID+"/messages"}>Fridge</MenuItem>
            <MenuItem hash={"/houses/"+this.props.houseID+"/chores"}>Chores</MenuItem>
            <MenuItem hash={"/houses/"+this.props.houseID+"/events"}>Events</MenuItem>
            <MenuItem hash={"/houses/"+this.props.houseID+"/communal_items"}>Inventory</MenuItem>
            <MenuItem hash={"/houses/"+this.props.houseID+"/bills"}>Bills</MenuItem>
            <MenuItem hash={"/houses/"+this.props.houseID+"/rules"}>Rules</MenuItem>
            <MenuItem hash={"/houses/"+this.props.houseID+"/roommates"}>Roommates</MenuItem>
            <MenuItem hash={"/houses/"+this.props.houseID}>House Info</MenuItem>
            <MenuItem hash={"/users/"+this.props.userID}>Profile</MenuItem>
          </Menu>
        </div>
      </ul>
    ) : (
      <div></div>
    );

    return (
      <nav className="top-bar" data-topbar role="navigation">
        <section className="top-bar-section">
          {leftNav}
          {rightNav}
          <div className="top-logo"><a href="/">House Rules</a></div>
        </section>
      </nav>
    );
  }
});

// window.Header = Header;
// module.exports = Header;

