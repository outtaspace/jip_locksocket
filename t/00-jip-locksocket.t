#!/usr/bin/env perl

use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;
use English qw(-no_match_vars);

plan tests => 2;

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

subtest 'new()' => sub {
    plan tests => 7;

    eval { JIP::LockSocket->new } or do {
        like $EVAL_ERROR, qr{Mandatory \s argument \s "port" \s is \s missing}x;
    };

    eval { JIP::LockSocket->new(port => undef) } or do {
        like $EVAL_ERROR, qr{Bad \s argument \s "port"}x;
    };

    eval { JIP::LockSocket->new(port => q{}) } or do {
        like $EVAL_ERROR, qr{Bad \s argument \s "port"}x;
    };

    my $obj = init_obj();
    ok $obj, 'got instance of JIP::LockSocket';

    isa_ok $obj, 'JIP::LockSocket';

    can_ok $obj, qw(new get_port lock try_lock unlock is_locked);

    is $obj->get_port, 4242;
};

sub init_obj {
    my $port = shift || 4242;
    return JIP::LockSocket->new(port => $port);
}

