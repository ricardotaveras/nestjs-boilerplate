---
inject: true
to: src/<%= h.inflection.transform(name, ['pluralize', 'underscore', 'dasherize']) %>/dto/create-<%= h.inflection.transform(name, ['underscore', 'dasherize']) %>.dto.ts
after: export class Create<%= name %>Dto
---
<% if (isAddToDto) { -%>
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
          [<%= type %>Dto],
        <% } else { -%>
          <%= type %>Dto,
        <% } -%>
      <% } -%>
  })

  <% if (kind === 'primitive') { -%>
    <% if (type === 'string') { -%>
      @IsString()
    <% } else if (type === 'number') { -%>
      @IsNumber()
    <% } else if (type === 'boolean') { -%>
      @IsBoolean()
    <% } -%>
  <% } else if (kind === 'reference') { -%>
    @ValidateNested()
    @Type(() => <%= type %>Dto)
    <% if (referenceType === 'oneToMany' || referenceType === 'manyToMany') { -%>
      @IsArray()
    <% } else { -%>
      @IsNotEmptyObject()
    <% } -%>
  <% } -%>

  <% if (kind === 'reference') { -%>
    <%= property %>: <%= type %>Dto<% if (referenceType === 'oneToMany' || referenceType === 'manyToMany') { -%>[]<% } -%>;
  <% } else { -%>
    <%= property %>: <%= type %>;
  <% } -%>
<% } -%>
