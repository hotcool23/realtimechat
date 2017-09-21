const invalidUsernameError =
  "must contain only letters, numbers, periods, hyphens, and underscores"
const invalidPasswordError =
  "can't be things like _password_, _123456_, or _abcdef_"

const invalidErrorFn = (type) => {
  switch (type.toLowerCase()) {
    case 'username':
      return invalidUsernameError;
    case 'password':
      return invalidPasswordError;
  }
}

const isValid = (errors, type) => {
  return errors[type].includes(invalidErrorFn(type))
}

const getErrors = (errors, type) => {
  const result = [];

  const invalidError = invalidErrorFn(type);

  for (let i = 0; i < errors[type.toLowerCase()].length; i++) {
    let error = errors[type.toLowerCase()][i]
    if (error !== invalidError) {
      result.push('• ' + type + error)
    }
  }

  return result;
}


export const isValidUsername = (errors) => {
  return isValid(errors, 'username')
}

export const isValidPassword = (errors) => {
  return isValid(errors, 'password')
}

export const usernameErrors = (errors) => {
  return getErrors(errors, 'Username')
}

export const passwordErrors = (errors) => {
  return getErrors(errors, 'Password')
}
