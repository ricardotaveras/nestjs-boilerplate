---
inject: true
to: src/<%= h.inflection.transform(name, ['pluralize', 'underscore', 'dasherize']) %>/<%= h.inflection.transform(name, ['pluralize', 'underscore', 'dasherize']) %>.service.ts
at_line: 0
skip_if: HttpStatus,
---
<% if (kind === 'reference' && isAddToDto) { -%>
  import { HttpStatus, UnprocessableEntityException } from '@nestjs/common';
<% } -%>