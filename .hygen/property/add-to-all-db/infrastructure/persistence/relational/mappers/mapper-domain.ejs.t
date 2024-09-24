---
inject: true
to: src/<%= h.inflection.transform(name, ['pluralize', 'underscore', 'dasherize']) %>/infrastructure/persistence/relational/mappers/<%= h.inflection.transform(name, ['underscore', 'dasherize']) %>.mapper.ts
after: new <%= name %>\(\)
---
<% if (kind === 'primitive') { -%>
  domainEntity.<%= property %> = raw.<%= property %>;
<% } else if (kind === 'reference') { -%>
  <% if (referenceType === 'oneToOne') { -%>
    if (raw.<%= property %>) {
      domainEntity.<%= property %> = <%= type %>Mapper.toDomain(raw.<%= property %>);
    }
  <% } else if (referenceType === 'oneToMany' || referenceType === 'manyToMany') { -%>
    if (raw.<%= property %>) {
      domainEntity.<%= property %> = raw.<%= property %>.map((item) => <%= type %>Mapper.toDomain(item));
    }
  <% } -%>
<% } -%>



