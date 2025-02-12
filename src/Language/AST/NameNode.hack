namespace GraphQL\Language\AST;

class NameNode extends Node implements TypeNode
{
    /** @var string */
    public $kind = NodeKind::NAME;

    /** @var string */
    public $value;
}
