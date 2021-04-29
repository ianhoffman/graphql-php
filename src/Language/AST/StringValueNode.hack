namespace GraphQL\Language\AST;

class StringValueNode extends Node implements ValueNode
{
    /** @var string */
    public $kind = NodeKind::STRING;

    /** @var string */
    public $value;

    /** @var bool */
    public $block;
}
