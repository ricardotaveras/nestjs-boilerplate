---
inject: true
to: src/<%= h.inflection.transform(name, ['pluralize', 'underscore', 'dasherize']) %>/<%= h.inflection.transform(name, ['pluralize', 'underscore', 'dasherize']) %>.service.ts
after: \<creating\-property \/\>
---
<% if (isAddToDto) { -%>
  <% if (kind === 'reference') { -%>
    <% if (referenceType === 'oneToOne') { -%>
      const <%= property %>Object = await this.<%= h.inflection.camelize(type, true) %>Service.findById(
        create<%= name %>Dto.<%= property %>.id,
      );
      if (!<%= property %>Object) {
        throw new UnprocessableEntityException({
          status: HttpStatus.UNPROCESSABLE_ENTITY,
          errors: {
            <%= property %>: 'notExists',
          },
        });
      }
      const <%= property %> = <%= property %>Object;
    <% } else if (referenceType === 'oneToMany' || referenceType === 'manyToMany') { -%>
      const <%= property %>Objects = await this.<%= h.inflection.camelize(type, true) %>Service.findByIds(
        create<%= name %>Dto.<%= property %>.map((entity) => entity.id),
      );
      if (<%= property %>Objects.length !== create<%= name %>Dto.<%= property %>.length) {
        throw new UnprocessableEntityException({
          status: HttpStatus.UNPROCESSABLE_ENTITY,
          errors: {
            <%= property %>: 'notExists',
          },
        });
      }
      const <%= property %> = <%= property %>Objects;
    <% } -%>
  <% } -%>
<% } -%>