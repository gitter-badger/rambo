import os
import sys

import click
from bash import bash

from rambo.settings import PROJECT_NAME, PROVIDERS
from rambo.app import setup_lastpass, vagrant_up, vagrant_ssh, vagrant_destroy

cmd = ''
command_handeled_by_click = ['up','destory','ssh']
if len(sys.argv) > 1:
    cmd = (sys.argv[1])
    if cmd in command_handeled_by_click:
        cmd = ''

@click.group()
@click.option('--debug/--no-debug', default=False)
@click.pass_context
def cli(ctx, debug):
    ctx.obj['DEBUG'] = debug

context_settings = {'ignore_unknown_options':True, 'allow_extra_args':True}
@cli.command(name=cmd, context_settings=context_settings)
@click.pass_context
def gen(ctx):
    # TODO: figure out better warning system
    click.echo("warning -- you entered a command " + PROJECT_NAME  +
               " does not understand. passing raw commands to vagrant backend")
    click.echo('you ran "', ' '.join(list(sys.argv)),'"')
    click.echo('vagrant backend says:')
    click.echo(bash('vagrant ' + sys.argv[1]).stdout)

@cli.command()
@click.option('-p', '--provider', default=None,
              help='Provider for the virtual machine. '
              'These providers are supported: %s. Default virtualbox.' % PROVIDERS)
@click.pass_context
def up(ctx, provider):
    '''
    Call Vagrant up with provider option. Provider may also be supplied by
    the RAMBO_PROVIDER environment variable if not passed as a cli option.
    '''
    envvar = '_'.join([PROJECT_NAME.upper(), 'PROVIDER'])
    if provider: # Set it only if it's passed so we can use an existing value.
        os.environ[envvar] = provider
    try:
        # Abort if provider not in whitelist.
        if os.environ[envvar] not in PROVIDERS:
            # TODO See if there's a better exit / error system
            if provider:
                sys.exit('ABORTED - Target provider "%s" is not in the providers '
                         'list. Did you have a typo?' % provider)
            else:
                sys.exit('ABORTED - Target provider was not passed, but it is set as '
                         'the environment varibale "%s" to "%s", and it is not in the '
                         'providers list.' % (envvar, os.environ[envvar]))
    except KeyError: # provider not set as env var
        pass
    vagrant_up()

@cli.command()
@click.pass_context
def ssh(ctx):
    vagrant_ssh()

@cli.command()
@click.pass_context
def destroy(ctx):
    vagrant_destroy()

@cli.command()
@click.pass_context
def setup(ctx): # threaded setup commands
    # setup_rambo()
    setup_lastpass()

def main():
    cli(obj={})

if __name__ == '__main__':
    main()
