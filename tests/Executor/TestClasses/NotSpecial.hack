namespace GraphQL\Tests\Executor\TestClasses;

class NotSpecial
{
    /** @var string */
    public $value;

    /**
     * @param string $value
     */
    public function __construct($value)
    {
        $this->value = $value;
    }
}
