use strict;
use warnings;
use Test::More;

use File::Basename qw//;
use YAML qw//;

use Woothee;

sub message {
    my ($setname, $target, $attribute) = @_;
    sprintf("%s test(%s): %s", $setname, $attribute, $target);
}

sub run_testset {
    my ($testsets_file, $set_name) = @_;
    my $entries = YAML::LoadFile($testsets_file);
    foreach my $entry (@$entries) {
        my $r = Woothee::parse($entry->{target});
        is ($r->{name}, $entry->{name}, message($set_name, $entry->{target}, "name"));
        is ($r->{category}, $entry->{category}, message($set_name, $entry->{target}, "category"));
        if (exists $entry->{os}) {
            is ($r->{os}, $entry->{os}, message($set_name, $entry->{target}, "os"));
        }
        if (exists $entry->{os_version}) {
            is ($r->{os_version}, $entry->{os_version}, message($set_name, $entry->{target}, "os_version"));
        }
        if (exists $entry->{version}) {
            is ($r->{version}, $entry->{version}, message($set_name, $entry->{target}, "version"));
        }
        if (exists $entry->{vendor}) {
            is ($r->{vendor}, $entry->{vendor}, message($set_name, $entry->{target}, "vendor"));
        }
    }
}

my $testset_dir = File::Basename::dirname(__FILE__) . "/testsets/";

subtest 'crawler' => sub { run_testset($testset_dir . "crawler.yaml", "Crawler"); };
subtest 'crawler_google' => sub { run_testset($testset_dir . "crawler_google.yaml", "Crawler/Google"); };
subtest 'pc_windows' => sub { run_testset($testset_dir . "pc_windows.yaml", "PC/Windows"); };
subtest 'pc_misc' => sub { run_testset($testset_dir . "pc_misc.yaml", "PC/Misc"); };
subtest 'mobilephone_docomo' => sub { run_testset($testset_dir . "mobilephone_docomo.yaml", "MobilePhone/docomo"); };
subtest 'mobilephone_au' => sub { run_testset($testset_dir . "mobilephone_au.yaml", "MobilePhone/au"); };
subtest 'mobilephone_softbank' => sub { run_testset($testset_dir . "mobilephone_softbank.yaml", "MobilePhone/softbank"); };
subtest 'mobilephone_willcom' => sub { run_testset($testset_dir . "mobilephone_willcom.yaml", "MobilePhone/willcom"); };
subtest 'mobilephone_misc' => sub { run_testset($testset_dir . "mobilephone_misc.yaml", "MobilePhone/misc"); };
subtest 'smartphone_ios' => sub { run_testset($testset_dir . "smartphone_ios.yaml", "SmartPhone/ios"); };
subtest 'smartphone_android' => sub { run_testset($testset_dir . "smartphone_android.yaml", "SmartPhone/android"); };
subtest 'smartphone_misc' => sub { run_testset($testset_dir . "smartphone_misc.yaml", "SmartPhone/misc"); };
subtest 'appliance' => sub { run_testset($testset_dir . "appliance.yaml", "Appliance"); };
subtest 'pc_lowpriority' => sub { run_testset($testset_dir . "pc_lowpriority.yaml", "PC/LowPriority"); };
subtest 'misc' => sub { run_testset($testset_dir . "misc.yaml", "Misc"); };
subtest 'crawler_nonmajor' => sub { run_testset($testset_dir . "crawler_nonmajor.yaml", "Crawler/NonMajor"); };

done_testing;
