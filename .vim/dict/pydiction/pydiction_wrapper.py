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


def process_django():

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


    # packages
    args.extend([a for a in settings.INSTALLED_APPS if not ptn.search(a)])
    # models
    args.extend([m.__module__ for m in get_models() if not ptn.search(m.__module__)])

    # clean
    _cl_args = list(set(args))
    _cl_args.sort()
    cl_args = _cl_args

    print " ".join(cl_args)

def process_flask():
    pass

def process_tornado():
    pass

def main(args):
    """main"""
    if args.django:
        process_django()
    elif args.flask:
        process_flask()
    elif args.tornado:
        process_tornado()
    else:
        raise ArgsError('Input Arguments or Options.')

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="ctags util for virtualenv.")
    parser.add_argument('path', nargs='?', default='.',
            help='project path.')
    parser.add_argument('-d', '--django', action='store_true',
            help='django packages and project packages.')
    parser.add_argument('-f', '--flask', action='store_true',
            help='flask pakages')
    parser.add_argument('-t', '--tornado', action='store_true',
            help='tornado packages')
    parser.add_argument('-v', '--version', action='version', version='%(prog)s ' + __version__)

    args = parser.parse_args()
    main(args)

