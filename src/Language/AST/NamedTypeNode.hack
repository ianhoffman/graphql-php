namespace GraphQL\Language\AST;

class NamedTypeNode extends Node implements TypeNode
{
    /** @var string */
    public $kind = NodeKind::NAMED_TYPE;

    /** @var NameNode */
    public $name;
}
