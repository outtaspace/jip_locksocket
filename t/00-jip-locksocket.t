#!/usr/bin/env perl

use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;
use English qw(-no_match_vars);

plan tests => 1;

subtest 'Require some module' => sub {
    plan tests => 2;

    use_ok 'JIP::LockSocket', '0.01';
    require_ok 'JIP::LockSocket';

    diag(
        sprintf 'Testing JIP::LockSocket %s, Perl %s, %s',
            $JIP::LockSocket::VERSION,
            $PERL_VERSION,
            $EXECUTABLE_NAME,
    );
};

