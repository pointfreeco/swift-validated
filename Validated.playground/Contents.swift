import Validated

struct User {
  let id: Int
  let email: String
  let name: String
}

func validate(id: Int) -> Validated<Int, String> {
  return id > 0
    ? .valid(id)
    : .error("id must be greater than zero")
}

func validate(email: String) -> Validated<String, String> {
  return email.contains("@")
    ? .valid(email)
    : .error("email must be valid")
}

func validate(name: String) -> Validated<String, String> {
  return !name.isEmpty
    ? .valid(name)
    : .error("name can't be blank")
}

let validUser = zip(with: User.init)(
  validate(id: 1),
  validate(email: "blob@pointfree.co"),
  validate(name: "Blob")
)
validUser.isValid
validUser.value

let invalidUser = zip(with: User.init)(
  validate(id: -1),
  validate(email: "blobpointfree.co"),
  validate(name: "")
)
invalidUser.isValid
invalidUser.errors
