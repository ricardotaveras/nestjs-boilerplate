---
inject: true
to: src/<%= h.inflection.transform(name, ['pluralize', 'underscore', 'dasherize']) %>/infrastructure/persistence/relational/entities/<%= h.inflection.transform(name, ['underscore', 'dasherize']) %>.entity.ts
after: export class <%= name %>Entity
---

@Column()
<% if (kind === 'reference') { -%>
  <% if (referenceType === 'oneToOne') { -%>
    @OneToOne(() => <%= type %>Entity, { eager: true })
  <% } else if (referenceType === 'oneToMany') { -%>
    @OneToMany(() => <%= type %>Entity, (childEntity) => childEntity.<%= h.inflection.camelize(name, true) %>, { eager: true })
  <% } else if (referenceType === 'manyToMany') { -%>
    @ManyToMany(() => <%= type %>Entity, { eager: true })
  <% } -%>

  <% if (referenceType === 'oneToOne' || referenceType === 'manyToMany') { -%>
    @JoinColumn()
  <% } -%>

  <%= property %>: <%= type %>Entity<% if (referenceType === 'oneToMany' || referenceType === 'manyToMany') { -%>[]<% } -%>;
<% } else { -%>
  <%= property %>: <%= type %>;
<% } -%>


