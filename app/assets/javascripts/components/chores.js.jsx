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
      /* We'll have ingredients */
      this.chores = options.chores || [];
      /* Those ingredients can be updated and deleted */
      this.bindActions(fluxChoresStore.constants.UPDATE_CHORE, this.onUpdateChore, fluxChoresStore.constants.DELETE_CHORE, this.onDeleteChore);
    },
    getState: function() {
      /* If someone asks the store what the ingredients are, show them */
      return {
        chores: this.chores,
      };
    },
    onUpdateChore: function(payload) {
      /* Update the model if an ingredient is renamed */
      payload.chore.task = payload.new_name;
      this.emit("change")
    },
    onDeleteChore: function(payload) {
      /* Update the model if an ingredient is deleted */
      this.chores = this.chores.filter(function(chore) {
        return chore.id != payload.chore.id
      });
      this.emit("change");
    }
  });

  fluxChoresStore.actions = {
    updateChore: function(chore, new_name) {
      /* First, update the model by calling the function above */
      this.dispatch(fluxChoresStore.constants.UPDATE_CHORE, {
        chore: chore,
        new_name: new_name
      });
      /* Then, update the server and show a success message */
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
      /* First, update the model by calling the function above */
      this.dispatch(fluxChoresStore.constants.DELETE_CHORE, {
        chore: chore
      });
      /* Then, delete it on the server and show a success message */
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

  /* Initalize the Fluxxor store when needed */
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
    /* Update this component when the Fluxxor store is updated */
    mixins: [FluxMixin, StoreWatchMixin("ChoresStore")],
    /* Get the ingredients list from the store */
    getStateFromFlux: function() {
      var flux = this.getFlux();
      return {
        chores: flux.store("ChoresStore").getState().chores
      };
    },
    /* Show each ingredient when the IngredientSuggestion component */
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
    /* We need this mixin since we are calling Flux store actions from this component */
    mixins: [FluxMixin],
    /* We'll track two things for each ingredient, whether the user has changed its name and whether they have saved the update to the server. */
    getInitialState: function() {
      return {changed: false, updated: false};
    },
    render: function() {

      return (
        <div>
          <a href="#" onClick={this.handleDelete}><i className="fa fa-times"></i></a>
          <input onChange={this.handleChange} ref="chore" defaultValue={this.props.chore.task}/>
          {/* Show the Update and Cancel buttons only if the user has changed the ingredient name */
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
      /* If the user changed the ingredient name, set the 'changed' state to true */
      if ($(this.refs.chore.getDOMNode()).val() != this.props.chore.task) {
        this.setState({changed: true});
      } else {
        this.setState({changed: false});
      }
    },
    handleUpdate: function(e) {
      /* Update the ingredient name in the Fluxxor store */
      e.preventDefault();
      this.getFlux().actions.updateChore(this.props.chore, $(this.refs.chore.getDOMNode()).val());
      this.setState({changed: false, updated: true});
    },
    handleDelete: function(e) {
      /* Delete the ingredient from the Fluxxor store */
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
