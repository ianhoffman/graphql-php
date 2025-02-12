namespace GraphQL\Language\AST;

class FragmentSpreadNode extends Node implements SelectionNode
{
    /** @var string */
    public $kind = NodeKind::FRAGMENT_SPREAD;

    /** @var NameNode */
    public $name;

    /** @var NodeList<DirectiveNode> */
    public $directives;
}
