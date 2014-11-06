class Cruddy.Fields.Relation extends Cruddy.Fields.BaseRelation

    createInput: (model, inputId, forceDisable = no) -> new Cruddy.Inputs.EntityDropdown
        model: model
        key: @id
        multiple: @attributes.multiple
        reference: @getReference()
        owner: @entity.id + "." + @id
        constraint: @attributes.constraint
        enabled: not forceDisable and @isEditable(model)

    createFilterInput: (model) -> new Cruddy.Inputs.EntityDropdown
        model: model
        key: @id
        reference: @getReference()
        allowEdit: no
        placeholder: Cruddy.lang.any_value
        owner: @entity.id + "." + @id
        constraint: @attributes.constraint
        multiple: yes

    isEditable: -> @getReference().viewPermitted() and super

    canFilter: -> @getReference().viewPermitted() and super

    formatItem: (item) ->
        ref = @getReference()

        return item.title unless ref.viewPermitted()

        """<a href="#{ ref.link item.id }">#{ _.escape item.title }</a>"""

    prepareAttribute: (value) ->
        return null unless value?

        return _.pluck value, "id" if _.isArray value

        return value.id

    prepareFilterData: (value) -> @prepareAttribute value