---
inject: true
to: src/<%= h.inflection.transform(name, ['pluralize', 'underscore', 'dasherize']) %>/infrastructure/persistence/relational/mappers/<%= h.inflection.transform(name, ['underscore', 'dasherize']) %>.mapper.ts
after: new <%= name %>Entity\(\)
---
<% if (kind === 'primitive') { -%>
  persistenceEntity.<%= property %> = domainEntity.<%= property %>;
<% } else if (kind === 'reference') { -%>
  <% if (referenceType === 'oneToOne') { -%>
    if (domainEntity.<%= property %>) {
      persistenceEntity.<%= property %> = <%= type %>Mapper.toPersistence(domainEntity.<%= property %>);
    }
  <% } else if (referenceType === 'oneToMany' || referenceType === 'manyToMany') { -%>
    if (domainEntity.<%= property %>) {
      persistenceEntity.<%= property %> = domainEntity.<%= property %>.map((item) => <%= type %>Mapper.toPersistence(item));
    }
  <% } -%>
<% } -%>



