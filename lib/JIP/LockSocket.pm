package JIP::LockSocket;

use 5.006;
use strict;
use warnings;
use Carp qw(croak);
use English qw(-no_match_vars);

our $VERSION = '0.01';

sub new {
    my ($class, %param) = @ARG;

    # Mandatory options
    croak qq{Mandatory argument "port" is missing\n}
        unless exists $param{'port'};

    # Check "port"
    my $port = $param{'port'};
    croak qq{Bad argument "port"\n}
        unless defined $port and $port =~ m{^\d+$}x;

    # Class to object
    return bless({}, $class)->_set_port($port);
}

# Accessor
sub get_port {
    my $self = shift;
    return $self->{'port'};
}

# Lock or raise an exception
sub lock {}

# Or just return undef
sub try_lock {}

# But trying to get a lock is ok
sub is_locked {}

# You can manually unlock
sub unlock {}

# unlocking on scope exit
sub DESTROY {
    my $self = shift;
    return $self->unlock;
}

# private methods ...
sub _set_port {
    my ($self, $port) = @ARG;
    $self->{'port'} = $port;
    return $self;
}

1;

__END__

=head1 NAME

JIP::LockSocket - application lock/mutex based on sockets

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

    use JIP::LockSocket;

    my $port = 4242;

    my $foo = JIP::LockSocket->new(port => $port);
    my $wtf = JIP::LockSocket->new(port => $port);

    $foo->lock;           # lock
    eval { $wtf->lock; }; # or raise exception

    # Can check its status in case you forgot
    $foo->is_locked; # 1
    $wtf->is_locked; # 0

    $foo->lock; # Re-locking changes nothing

    # But trying to get a lock is ok
    $wtf->try_lock;  # 0
    $wtf->is_locked; # 0

    # You can manually unlock
    $foo->unlock;

    # Re-unlocking changes nothing
    $foo->unlock;

    # ... or unlocking is automatic on scope exit
    undef $foo;

=head1 AUTHOR

Vladimir Zhavoronkov, C<< <flyweight at yandex.ru> >>

=head1 LICENSE AND COPYRIGHT

Copyright 2015 Vladimir Zhavoronkov.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS' AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

