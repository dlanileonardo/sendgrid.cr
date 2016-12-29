module Sendgrid
  alias ExtraFieldsType = Bool |
                          Int32 |
                          String |
                          Array(ExtraFieldsType) |
                          Hash(String, ExtraFieldsType)

  alias ExtraFields = Hash(String, ExtraFieldsType)
end
