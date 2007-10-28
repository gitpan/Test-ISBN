# $Id: prereq.t 1470 2004-09-08 09:10:23Z comdog $
use Test::More;
eval "use Test::Prereq";
plan skip_all => "Test::Prereq required to test dependencies" if $@;
prereq_ok();
