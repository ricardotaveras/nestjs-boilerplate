---
inject: true
to: src/<%= h.inflection.transform(name, ['pluralize', 'underscore', 'dasherize']) %>/<%= h.inflection.transform(name, ['pluralize', 'underscore', 'dasherize']) %>.service.ts
after: \<updating\-property \/\>
---
<% if (isAddToDto) { -%>
  <% if (kind === 'reference') { -%>
    <% if (referenceType === 'oneToOne') { -%>
      let <%= property %>: <%= type %><% if (type === 'File') { -%>Type<% } -%> | undefined = undefined;

      if (update<%= name %>Dto.<%= property %>) {
        const <%= property %>Object = await this.<%= h.inflection.camelize(type, true) %>Service.findById(
          update<%= name %>Dto.<%= property %>.id,
        );
        if (!<%= property %>Object) {
          throw new UnprocessableEntityException({
            status: HttpStatus.UNPROCESSABLE_ENTITY,
            errors: {
              <%= property %>: 'notExists',
            },
          });
        }
        <%= property %> = <%= property %>Object;
      }
    <% } else if (referenceType === 'oneToMany' || referenceType === 'manyToMany') { -%>
      let <%= property %>: <%= type %><% if (type === 'File') { -%>Type<% } -%>[] | undefined = undefined;

      if (update<%= name %>Dto.<%= property %>?.length) {
        const <%= property %>Objects = await this.<%= h.inflection.camelize(type, true) %>Service.findByIds(
          update<%= name %>Dto.<%= property %>.map((entity) => entity.id),
        );
        if (<%= property %>Objects.length !== update<%= name %>Dto.<%= property %>.length) {
          throw new UnprocessableEntityException({
            status: HttpStatus.UNPROCESSABLE_ENTITY,
            errors: {
              <%= property %>: 'notExists',
            },
          });
        }
        <%= property %> = <%= property %>Objects;
      }
    <% } -%>
  <% } -%>
<% } -%>