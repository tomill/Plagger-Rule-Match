package Plagger::Rule::Match;
use strict;
use base qw( Plagger::Rule );

use Encode;
use List::MoreUtils qw/all/;
use Match::Smart qw/smart_match/; 

sub init {
    my $self = shift;
    
    for my $cond (values %$self) {
        $cond = $self->encode_walk($cond);   
    }
}

sub encode_walk {
    my ($self, $var) = @_;
    
    if (ref $var eq 'ARRAY') {
        @$var = map { $self->encode_walk($_) } @$var;
    } elsif (ref $var eq 'HASH') {
        %$var = map { $_ => $self->encode_walk($var->{$_}) } keys %$var;
    } elsif (!ref $var) {
        $var = decode('utf-8', $var);
        $var = qr/$var/;
    }
    return $var;
}

sub dispatch {
    my ($self, $args) = @_;
    
    my @bool;
    for my $type (keys %$self) {

        my $obj = $args->{$type}
            or Plagger->context->error("No $type object");
        
        for my $key (keys %{$self->{$type}}) {
            if ( smart_match($obj->$key(), $self->{$type}{$key}) ) {
                push @bool, 1;
            } else {
                push @bool, 0;
            }
        }
    }
     
    return all { $_ } @bool;
}

1;
__END__

=head1 NAME

Plagger::Rule::Match - Rule to keyword match simply

=head1 SYNOPSIS

  - module: Filter::Rule
    rule:
      - module: Match 
        feed:
          url: www.google.com/searchhistory
        entry:
          title: 
            - "^later "
            - "^todo "

=head1 DESCRIPTION

The rule is for simple filtering.

=head1 AUTHOR

Naoki Tomita

=head1 SEE ALSO

L<Plagger>

=cut
