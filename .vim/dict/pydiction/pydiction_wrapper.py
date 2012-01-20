#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
===========================
wrapper
===========================
:create_date:  2012-01-07T19:48:43
"""
__version__ = "0.2"

import argparse
import re


class ArgsError(Exception):
    pass


def process_django(packages):

    import settings
    from django.core.management import setup_environ
    setup_environ(settings)

    # from django.conf import settings
    from django.db.models.loading import get_models

    ptn = re.compile('django')

    args = [
    "django",
    "django.contrib",
    "django.contrib.admin",
    "django.db",
    "django.db.models",
    "django.db.models.fields",
    "django.forms",
    "django.forms.extras",
    "django.http",
    "django.shortcuts",
    "django.utils",
    ]

    # install packages
    args.extend([a for a in settings.INSTALLED_APPS if not ptn.search(a)])
    # models
    args.extend([m.__module__ for m in get_models() if not ptn.search(m.__module__)])

    if packages:
        args.extend(packages)

    # clean
    _cl_args = list(set(args))
    _cl_args.sort()
    cl_args = _cl_args

    print(" ".join(cl_args))

def process_flask(packages):
    print("flask werkzeug %s " % " ".join(packages))

def process_tornado(packages):
    print("tornado %s " % " ".join(packages))

def process_normal(packages):
    print(" ".join(packages))

def main(args):
    """main"""
    if args.django:
        process_django(args.packages)
    elif args.flask:
        process_flask(args.packages)
    elif args.tornado:
        process_tornado(args.packages)
    elif args.normal:
        process_normal(args.packages)
    else:
        raise ArgsError('Input Arguments or Options.')

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="pydiction.py util")
    parser.add_argument('packages', nargs='+', default=[],
            help='parse packages.')
    parser.add_argument('-n', '--normal', action='store_true',
            help='No additional packages.')
    parser.add_argument('-d', '--django', action='store_true',
            help='django packages and project packages.')
    parser.add_argument('-f', '--flask', action='store_true',
            help='flask pakages')
    parser.add_argument('-t', '--tornado', action='store_true',
            help='tornado packages')
    parser.add_argument('-v', '--version', action='version', version='%(prog)s ' + __version__)

    args = parser.parse_args()

    main(args)

