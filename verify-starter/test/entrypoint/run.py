import click

@click.command()
@click.option(
    "--example_arg",
    help='Example CLI argument',
)
def main(example_arg):
    print(example_arg)

if __name__ == "__main__":
    main()
