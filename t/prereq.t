# $Id: prereq.t,v 1.1 2004/09/08 09:10:23 comdog Exp $
use Test::More;
eval "use Test::Prereq";
plan skip_all => "Test::Prereq required to test dependencies" if $@;
prereq_ok();
