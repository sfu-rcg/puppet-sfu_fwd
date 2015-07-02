# Not working for clearing rules properly unless you specify absent, I would suggest doing ALL rules via the customzone method
# as it will ensure only the rules that you have in your config will be applied at any time.
class sfu_fwd::customrule($firewallhash = {}) {
  create_resources('::firewalld::rich_rule', $firewallhash)
}
