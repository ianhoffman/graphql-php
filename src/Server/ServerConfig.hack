namespace GraphQL\Server;

use GraphQL\Error\DebugFlag;
use GraphQL\Error\InvariantViolation;
use GraphQL\Executor\Promise\PromiseAdapter;
use GraphQL\Type\Schema;
use GraphQL\Utils\Utils;
use GraphQL\Validator\Rules\ValidationRule;

use function is_array;
use function is_callable;
use function method_exists;
use function sprintf;
use function ucfirst;

/**
 * Server configuration class.
 * Could be passed directly to server constructor. List of options accepted by **create** method is
 * [described in docs](executing-queries.md#server-configuration-options).
 *
 * Usage example:
 *
 *     $config = GraphQL\Server\ServerConfig::create()
 *         ->setSchema($mySchema)
 *         ->setContext($myContext);
 *
 *     $server = new GraphQL\Server\StandardServer($config);
 */
class ServerConfig
{
    /**
     * Converts an array of options to instance of ServerConfig
     * (or just returns empty config when array is not passed).
     *
     * @param mixed[] $config
     *
     * @return ServerConfig
     *
     * @api
     */
    public static function create(array $config = [])
    {
        $instance = new static();
        foreach ($config as $key => $value) {
            $method = 'set' . ucfirst($key);
            if (! method_exists($instance, $method)) {
                throw new InvariantViolation(sprintf('Unknown server config option "%s"', $key));
            }

            $instance->$method($value);
        }

        return $instance;
    }

    /** @var Schema|null */
    private $schema;

    /** @var mixed|callable */
    private $context;

    /** @var mixed|callable */
    private $rootValue;

    /** @var callable|null */
    private $errorFormatter;

    /** @var callable|null */
    private $errorsHandler;

    /** @var int */
    private $debugFlag = DebugFlag::NONE;

    /** @var bool */
    private $queryBatching = false;

    /** @var ValidationRule[]|callable|null */
    private $validationRules;

    /** @var callable|null */
    private $fieldResolver;

    /** @var PromiseAdapter|null */
    private $promiseAdapter;

    /** @var callable|null */
    private $persistentQueryLoader;

    /**
     * @return self
     *
     * @api
     */
    public function setSchema(Schema $schema)
    {
        $this->schema = $schema;

        return $this;
    }

    /**
     * @param mixed|callable $context
     *
     * @return self
     *
     * @api
     */
    public function setContext($context)
    {
        $this->context = $context;

        return $this;
    }

    /**
     * @param mixed|callable $rootValue
     *
     * @return self
     *
     * @api
     */
    public function setRootValue($rootValue)
    {
        $this->rootValue = $rootValue;

        return $this;
    }

    /**
     * Expects function(Throwable $e) : array
     *
     * @return self
     *
     * @api
     */
    public function setErrorFormatter(callable $errorFormatter)
    {
        $this->errorFormatter = $errorFormatter;

        return $this;
    }

    /**
     * Expects function(array $errors, callable $formatter) : array
     *
     * @return self
     *
     * @api
     */
    public function setErrorsHandler(callable $handler)
    {
        $this->errorsHandler = $handler;

        return $this;
    }

    /**
     * Set validation rules for this server.
     *
     * @param ValidationRule[]|callable|null $validationRules
     *
     * @return self
     *
     * @api
     */
    public function setValidationRules($validationRules)
    {
        if (! is_callable($validationRules) && ! is_array($validationRules) && $validationRules !== null) {
            throw new InvariantViolation(
                'Server config expects array of validation rules or callable returning such array, but got ' .
                Utils::printSafe($validationRules)
            );
        }

        $this->validationRules = $validationRules;

        return $this;
    }

    /**
     * @return self
     *
     * @api
     */
    public function setFieldResolver(callable $fieldResolver)
    {
        $this->fieldResolver = $fieldResolver;

        return $this;
    }

    /**
     * Expects function($queryId, OperationParams $params) : string|DocumentNode
     *
     * This function must return query string or valid DocumentNode.
     *
     * @return self
     *
     * @api
     */
    public function setPersistentQueryLoader(callable $persistentQueryLoader)
    {
        $this->persistentQueryLoader = $persistentQueryLoader;

        return $this;
    }

    /**
     * Set response debug flags. @see \GraphQL\Error\DebugFlag class for a list of all available flags
     *
     * @api
     */
    public function setDebugFlag(int $debugFlag = DebugFlag::INCLUDE_DEBUG_MESSAGE): self
    {
        $this->debugFlag = $debugFlag;

        return $this;
    }

    /**
     * Allow batching queries (disabled by default)
     *
     * @api
     */
    public function setQueryBatching(bool $enableBatching): self
    {
        $this->queryBatching = $enableBatching;

        return $this;
    }

    /**
     * @return self
     *
     * @api
     */
    public function setPromiseAdapter(PromiseAdapter $promiseAdapter)
    {
        $this->promiseAdapter = $promiseAdapter;

        return $this;
    }

    /**
     * @return mixed|callable
     */
    public function getContext()
    {
        return $this->context;
    }

    /**
     * @return mixed|callable
     */
    public function getRootValue()
    {
        return $this->rootValue;
    }

    /**
     * @return Schema|null
     */
    public function getSchema()
    {
        return $this->schema;
    }

    /**
     * @return callable|null
     */
    public function getErrorFormatter()
    {
        return $this->errorFormatter;
    }

    /**
     * @return callable|null
     */
    public function getErrorsHandler()
    {
        return $this->errorsHandler;
    }

    /**
     * @return PromiseAdapter|null
     */
    public function getPromiseAdapter()
    {
        return $this->promiseAdapter;
    }

    /**
     * @return ValidationRule[]|callable|null
     */
    public function getValidationRules()
    {
        return $this->validationRules;
    }

    /**
     * @return callable|null
     */
    public function getFieldResolver()
    {
        return $this->fieldResolver;
    }

    /**
     * @return callable|null
     */
    public function getPersistentQueryLoader()
    {
        return $this->persistentQueryLoader;
    }

    public function getDebugFlag(): int
    {
        return $this->debugFlag;
    }

    /**
     * @return bool
     */
    public function getQueryBatching()
    {
        return $this->queryBatching;
    }
}
