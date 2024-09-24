---
inject: true
to: src/<%= h.inflection.transform(name, ['pluralize', 'underscore', 'dasherize']) %>/domain/<%= h.inflection.transform(name, ['underscore', 'dasherize']) %>.ts
after: export class <%= name %> {
---

@ApiProperty({
  type: () => 
    <% if (kind === 'primitive') { -%>
      <% if (type === 'string') { -%>
        String,
      <% } else if (type === 'number') { -%>
        Number,
      <% } else if (type === 'boolean') { -%>
        Boolean,
      <% } -%>
    <% } else if (kind === 'reference') { -%>
      <% if (referenceType === 'oneToMany' || referenceType === 'manyToMany') { -%>
        [<%= type %><% if (type === 'File') { -%>Type<% } -%>],
      <% } else { -%>
        <%= type %><% if (type === 'File') { -%>Type<% } -%>,
      <% } -%>
    <% } -%>
})

<% if (kind === 'reference') { -%>
  <%= property %>: <%= type %><% if (type === 'File') { -%>Type<% } -%><% if (referenceType === 'oneToMany' || referenceType === 'manyToMany') { -%>[]<% } -%>;
<% } else { -%>
  <%= property %>: <%= type %>;
<% } -%>
