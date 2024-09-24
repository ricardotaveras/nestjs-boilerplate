---
inject: true
to: src/<%= h.inflection.transform(name, ['pluralize', 'underscore', 'dasherize']) %>/infrastructure/persistence/document/entities/<%= h.inflection.transform(name, ['underscore', 'dasherize']) %>.schema.ts
after: export class <%= name %>SchemaClass
---

<% if (kind === 'reference') { -%>
  <% if (referenceType === 'oneToOne') { -%>
    @Prop({
      type: mongoose.Schema.Types.ObjectId,
      ref: '<%= type %>SchemaClass',
      autopopulate: true,
    })
    <%= property %>: <%= type %>SchemaClass;
  <% } else if (referenceType === 'oneToMany' || referenceType === 'manyToMany') { -%>
    @Prop({
      type: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: '<%= type %>SchemaClass',
        autopopulate: true,
      }]
    })
    <%= property %>: <%= type %>SchemaClass[];
  <% } -%>
<% } else { -%>
  @Prop()
  <%= property %>: <%= type %>;
<% } -%>