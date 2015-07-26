console.log "Recepies script activated"

class Recepie extends Backbone.Model
  initialize: () ->
    console.log "New Recepie added"


class RecepieGroup extends Backbone.Collection
  model: Recepie
  url: "" # set collection url here
  initialize: () ->
    data:
      name: "Shakkar Ki Lapsi"
      ingredients:
        ing_1:
          name: "Rua"
          quantity: "1/2 Cup"
        ing_2:
          name: "Sugar"
          quantity: "1/2 Cup"
        ing_3:
          name: "Ghee"
          quantity: "1 Cup"
      description: "Description over here"
      chefMessage: "Please try it and don't forget to share your feedback to me"

    console.log "New Recepie group added"


class RecepieView extends Backbone.Model.View
  initialize: () ->
    @model.bind "change", @render, this
    console.log "Recepie View added"

  template: _.template("
    <div class='name'>{{=it.name}}</div>
    <div class='ingredients-image'>
      <div class='ingredients'>{{=it.ingredients}}</div>
      <div class='image'></div>
    </div>
    <div class='description'>{{=it.description}}</div>
    <div class='chef-message'>{{=it.chefMessage}}</div>
  ")
  render: ->
    @$el.html @template(@model.toJSON())


class RecepieGroupView extends Backbone.Collection.View
  initialize: () ->
    console.log "Recepies Group added"

  template: _.template("
    <div class='recepie-container-block container-fluid'>
      {{~it :value:index}}
        <div class='recipie-block' id='recepie-{{=value.recepie_id}}'></div>
      {{~}}
    </div>
  ")

  render: () ->
    @$el.html @template(@collection.models[0])

    @collection.each (recepie) ->
      new RecepieView(model: recepie, el: @$el.find "div#recepie-#{recepie.attributes.recepie_id}")


recepieGroup = new RecepieGroup()
recepieGroupView = new RecepieGroupView(collection: recepieGroup, el: "section.recepies")
recepieGroup.fetch()
