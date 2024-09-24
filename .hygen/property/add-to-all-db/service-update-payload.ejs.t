---
inject: true
to: src/<%= h.inflection.transform(name, ['pluralize', 'underscore', 'dasherize']) %>/<%= h.inflection.transform(name, ['pluralize', 'underscore', 'dasherize']) %>.service.ts
after: \<updating\-property\-payload \/\>
---
<% if (isAddToDto) { -%>
  <% if (kind === 'reference') { -%>
    <%= property %>,
  <% } else { -%>
    <%= property %>: update<%= name %>Dto.<%= property %>,
  <% } -%>
<% } -%>