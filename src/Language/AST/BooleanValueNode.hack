namespace GraphQL\Language\AST;

class BooleanValueNode extends Node implements ValueNode
{
    /** @var string */
    public $kind = NodeKind::BOOLEAN;

    /** @var bool */
    public $value;
}
