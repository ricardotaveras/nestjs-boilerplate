---
inject: true
to: src/<%= h.inflection.transform(name, ['pluralize', 'underscore', 'dasherize']) %>/<%= h.inflection.transform(name, ['pluralize', 'underscore', 'dasherize']) %>.module.ts
after: imports.*\[
skip_if: <%= h.inflection.transform(type, ['pluralize']) %>Module,
---

<% if (kind === 'reference' && isAddToDto) { -%>
  <%= h.inflection.transform(type, ['pluralize']) %>Module,
<% } -%>
