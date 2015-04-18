FluxMixin = Fluxxor.FluxMixin(React);
StoreWatchMixin = Fluxxor.StoreWatchMixin;

/** @jsx React.DOM */

window.loadChoresEditor = function(chores) {


  /* DEFINE THE FLUXXOR STORE */

  var fluxChoresStore = {};

  fluxChoresStore.constants = {
    UPDATE_CHORE: "UPDATE_CHORE",
    DELETE_CHORE: "DELETE_CHORE",
  };

  fluxChoresStore.store = Fluxxor.createStore({
    initialize: function(options) {
      this.chores = options.chores || [];
      this.bindActions(fluxChoresStore.constants.UPDATE_CHORE, this.onUpdateChore, fluxChoresStore.constants.DELETE_CHORE, this.onDeleteChore);
    },
    getState: function() {
      return {
        chores: this.chores,
      };
    },
    onUpdateChore: function(payload) {
      payload.chore.task = payload.new_name;
      this.emit("change")
    },
    onDeleteChore: function(payload) {
      this.chores = this.chores.filter(function(chore) {
        return chore.id != payload.chore.id
      });
      this.emit("change");
    }
  });

  fluxChoresStore.actions = {
    updateChore: function(chore, new_name) {
      this.dispatch(fluxChoresStore.constants.UPDATE_CHORE, {
        chore: chore,
        new_name: new_name
      });
      $.ajax({
        type: "PUT",
        url: "/chores/" + chore.id,
        data: {
          task: new_name
        },
        success: function() {
          $.growl.notice({
            title: "Chore updated",
          });
        },
        failure: function() {
          $.growl.error({
            title: "Error updating chore",
          });
        }
      });
    },
    deleteChore: function(chore) {
      this.dispatch(fluxChoresStore.constants.DELETE_CHORE, {
        chore: chore
      });
      $.ajax({
        type: "DELETE",
        url: "/chores/" + chore.id,
        success: function(data) {
          $.growl.notice({
            title: "Chore deleted",
          });
        }.bind(this),
        failure: function() {
          $.growl.error({
            title: "Error deleting chore",
          });
        }
      });
    }
  };

  fluxChoresStore.init = function(chores) {
    var tempStore = {
      ChoresStore: new fluxChoresStore.store({
        chores: chores
      })
    };
    fluxChoresStore.flux = new Fluxxor.Flux(tempStore, fluxChoresStore.actions);
  }


  /* DEFINE REACT COMPONENTS */

  var ChoresEditor = React.createClass({
    mixins: [FluxMixin, StoreWatchMixin("ChoresStore")],
    getStateFromFlux: function() {
      var flux = this.getFlux();
      return {
        chores: flux.store("ChoresStore").getState().chores
      };
    },
    render: function() {
      var props = this.props;
      var chores = this.state.chores.map(function (chore) {
        return <Chore chore={chore} key={chore.id} flux={props.flux} />
      });
      return (
        <div>
          {chores}
        </div>
      );
    }
  });

  var Chore = React.createClass({
    mixins: [FluxMixin],
    getInitialState: function() {
      return {changed: false, updated: false};
    },
    render: function() {

      return (
        <div>
          <a href="#" onClick={this.handleDelete}>Delete</a>
          <input onChange={this.handleChange} ref="chore" defaultValue={this.props.chore.task}/>
          {
            this.state.changed ?
            <span>
              <a href="#" onClick={this.handleUpdate}>Update</a>
              <a href="#" onClick={this.handleCancelChange}>Cancel</a>
            </span>
          :
            ""
          }
        </div>
      )
    },
    handleChange: function() {
      if ($(this.refs.chore.getDOMNode()).val() != this.props.chore.task) {
        this.setState({changed: true});
      } else {
        this.setState({changed: false});
      }
    },
    handleUpdate: function(e) {
      e.preventDefault();
      this.getFlux().actions.updateChore(this.props.chore, $(this.refs.chore.getDOMNode()).val());
      this.setState({changed: false, updated: true});
    },
    handleDelete: function(e) {
      e.preventDefault();
      if (confirm("Delete " + this.props.chore.task + "?")) {
        this.getFlux().actions.deleteChore(this.props.chore);
      }
    },
    handleCancelChange: function(e) {
      e.preventDefault();
      $(this.refs.chore.getDOMNode()).val(this.props.chore.task);
      this.setState({changed: false});
    }
  });


  /* LOAD FLUXXOR STORE AND RENDER REACT COMPONENTS TO THE PAGE */

  fluxChoresStore.init(chores);
  React.render(<ChoresEditor flux={fluxChoresStore.flux} />,
    document.getElementById('js-chores-editor'));
}
