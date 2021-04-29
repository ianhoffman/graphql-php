namespace GraphQL\Type\Definition;

/**
export type InputType =
  | ScalarType
  | EnumType
  | InputObjectType
  | ListOfType<InputType>
  | NonNull<
      | ScalarType
      | EnumType
      | InputObjectType
      | ListOfType<InputType>,
    >;
 */
interface InputType
{
}
