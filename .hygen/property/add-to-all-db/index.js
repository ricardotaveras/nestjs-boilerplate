const collectPromisesResults = (callback) => async (prevValues) => {
  const results = await callback(prevValues);

  return { ...prevValues, ...results };
};

module.exports = {
  prompt: ({ prompter, args }) =>
    prompter
      .prompt({
        type: 'input',
        name: 'name',
        message: "Entity name (e.g. 'User')",
        validate: (input) => {
          if (!input.trim()) {
            return 'Entity name is required';
          }

          return true;
        },
        format: (input) => {
          return input.trim();
        },
      })
      .then(
        collectPromisesResults(() => {
          return prompter.prompt({
            type: 'input',
            name: 'property',
            message: "Property name (e.g. 'firstName')",
            validate: (input) => {
              if (!input.trim()) {
                return 'Property name is required';
              }

              return true;
            },
            format: (input) => {
              return input.trim();
            },
          });
        }),
      )
      .then(
        collectPromisesResults(() => {
          return prompter
            .prompt({
              type: 'select',
              name: 'kind',
              message: 'Select kind of type',
              choices: [
                {
                  message: 'Primitive (string, number, etc)',
                  value: 'primitive',
                },
                { message: 'Reference to entity', value: 'reference' },
                {
                  message: 'Duplication data from entity',
                  value: 'duplication',
                },
              ],
            })
            .then(
              collectPromisesResults((values) => {
                if (values.kind === 'reference') {
                  return prompter
                    .prompt({
                      type: 'input',
                      name: 'type',
                      message: "Entity name (e.g. 'File')",
                      validate: (input) => {
                        if (!input.trim()) {
                          return 'Entity name is required';
                        }

                        return true;
                      },
                      format: (input) => {
                        return input.trim();
                      },
                    })
                    .then(
                      collectPromisesResults(() => {
                        return prompter.prompt({
                          type: 'select',
                          name: 'referenceType',
                          message: 'Select type of reference',
                          choices: [
                            {
                              message: 'One to one',
                              value: 'oneToOne',
                            },
                            {
                              message: 'One to many',
                              value: 'oneToMany',
                            },
                            {
                              message: 'Many to many',
                              value: 'manyToMany',
                            },
                          ],
                        });
                      }),
                    );
                }

                return prompter.prompt({
                  type: 'select',
                  name: 'type',
                  message: 'Property type',
                  choices: ['string', 'number', 'boolean'],
                });
              }),
            );
        }),
      )
      .then(
        collectPromisesResults(() => {
          return prompter.prompt({
            type: 'confirm',
            name: 'isAddToDto',
            message: 'Add to DTO?',
            initial: true,
          });
        }),
      ),
};
