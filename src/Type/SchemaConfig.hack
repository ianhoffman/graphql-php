namespace GraphQL\Type;

use GraphQL\Language\AST\SchemaDefinitionNode;
use GraphQL\Language\AST\SchemaTypeExtensionNode;
use GraphQL\Type\Definition\Directive;
use GraphQL\Type\Definition\ObjectType;
use GraphQL\Type\Definition\Type;
use GraphQL\Utils\Utils;

use function count;
use function is_callable;

/**
 * Schema configuration class.
 * Could be passed directly to schema constructor. List of options accepted by **create** method is
 * described in the [schema definition docs](schema-definition.md#configuration-options).
 *
 * Usage example:
 *
 *     $config = SchemaConfig::create()
 *         ->setQuery($myQueryType)
 *         ->setTypeLoader($myTypeLoader);
 *
 *     $schema = new Schema($config);
 */
class SchemaConfig
{
    /** @var ObjectType|null */
    public $query;

    /** @var ObjectType|null */
    public $mutation;

    /** @var ObjectType|null */
    public $subscription;

    /** @var array<Type>|(callable(): array<Type>) */
    public $types = [];

    /** @var Directive[]|null */
    public $directives;

    /** @var callable|null */
    public $typeLoader;

    /** @var SchemaDefinitionNode|null */
    public $astNode;

    /** @var bool */
    public $assumeValid = false;

    /** @var array<int, SchemaTypeExtensionNode> */
    public $extensionASTNodes = [];

    /**
     * Converts an array of options to instance of SchemaConfig
     * (or just returns empty config when array is not passed).
     *
     * @param mixed[] $options
     *
     * @return SchemaConfig
     *
     * @api
     */
    public static function create(array $options = [])
    {
        $config = new static();

        if (count($options) > 0) {
            if (isset($options['query'])) {
                $config->setQuery($options['query']);
            }

            if (isset($options['mutation'])) {
                $config->setMutation($options['mutation']);
            }

            if (isset($options['subscription'])) {
                $config->setSubscription($options['subscription']);
            }

            if (isset($options['types'])) {
                $config->setTypes($options['types']);
            }

            if (isset($options['directives'])) {
                $config->setDirectives($options['directives']);
            }

            if (isset($options['typeLoader'])) {
                Utils::invariant(
                    is_callable($options['typeLoader']),
                    'Schema type loader must be callable if provided but got: %s',
                    Utils::printSafe($options['typeLoader'])
                );
                $config->setTypeLoader($options['typeLoader']);
            }

            if (isset($options['astNode'])) {
                $config->setAstNode($options['astNode']);
            }

            if (isset($options['assumeValid'])) {
                $config->setAssumeValid((bool) $options['assumeValid']);
            }

            if (isset($options['extensionASTNodes'])) {
                $config->setExtensionASTNodes($options['extensionASTNodes']);
            }
        }

        return $config;
    }

    /**
     * @return SchemaDefinitionNode|null
     */
    public function getAstNode()
    {
        return $this->astNode;
    }

    /**
     * @return SchemaConfig
     */
    public function setAstNode(SchemaDefinitionNode $astNode)
    {
        $this->astNode = $astNode;

        return $this;
    }

    /**
     * @return ObjectType|null
     *
     * @api
     */
    public function getQuery()
    {
        return $this->query;
    }

    /**
     * @param ObjectType|null $query
     *
     * @return SchemaConfig
     *
     * @api
     */
    public function setQuery($query)
    {
        $this->query = $query;

        return $this;
    }

    /**
     * @return ObjectType|null
     *
     * @api
     */
    public function getMutation()
    {
        return $this->mutation;
    }

    /**
     * @param ObjectType|null $mutation
     *
     * @return SchemaConfig
     *
     * @api
     */
    public function setMutation($mutation)
    {
        $this->mutation = $mutation;

        return $this;
    }

    /**
     * @return ObjectType|null
     *
     * @api
     */
    public function getSubscription()
    {
        return $this->subscription;
    }

    /**
     * @param ObjectType|null $subscription
     *
     * @return SchemaConfig
     *
     * @api
     */
    public function setSubscription($subscription)
    {
        $this->subscription = $subscription;

        return $this;
    }

    /**
     * @return array<Type>|(callable(): array<Type>)
     *
     * @api
     */
    public function getTypes()
    {
        return $this->types;
    }

    /**
     * @param array<Type>|(callable(): array<Type>) $types
     *
     * @return $this
     *
     * @api
     */
    public function setTypes($types): self
    {
        $this->types = $types;

        return $this;
    }

    /**
     * @return Directive[]|null
     *
     * @api
     */
    public function getDirectives()
    {
        return $this->directives;
    }

    /**
     * @param Directive[] $directives
     *
     * @return SchemaConfig
     *
     * @api
     */
    public function setDirectives(array $directives)
    {
        $this->directives = $directives;

        return $this;
    }

    /**
     * @return callable|null
     *
     * @api
     */
    public function getTypeLoader()
    {
        return $this->typeLoader;
    }

    /**
     * @return SchemaConfig
     *
     * @api
     */
    public function setTypeLoader(callable $typeLoader)
    {
        $this->typeLoader = $typeLoader;

        return $this;
    }

    /**
     * @return bool
     */
    public function getAssumeValid()
    {
        return $this->assumeValid;
    }

    /**
     * @param bool $assumeValid
     *
     * @return SchemaConfig
     */
    public function setAssumeValid($assumeValid)
    {
        $this->assumeValid = $assumeValid;

        return $this;
    }

    /**
     * @return SchemaTypeExtensionNode[]
     */
    public function getExtensionASTNodes()
    {
        return $this->extensionASTNodes;
    }

    /**
     * @param SchemaTypeExtensionNode[] $extensionASTNodes
     */
    public function setExtensionASTNodes(array $extensionASTNodes)
    {
        $this->extensionASTNodes = $extensionASTNodes;
    }
}
