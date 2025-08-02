#!/usr/bin/env python

import argparse
import os
import re
import statistics


class LogParser:
    def __init__(self, test_dir):
        self.logf = os.path.join(test_dir, "handler.log")
        self.measures = []
        self.errors = []
        self.zephyr_version = "???"

    def parse_banner(self, line):
        # match: "*** Booting Zephyr OS Build (XXXX) ***"
        m = re.match(r"\*\*\* Booting Zephyr OS build (.*) \*\*\*", line)
        if m:
            self.zephyr_version = m.group(1)
            return self.parse_measurement
        return self.parse_banner

    def parse_measurement(self, line):
        # skip empty line
        m = re.match(r"\s+", line)
        if m:
            return self.parse_measurement
        
        # match: "**** Thread-Metric (TEST_NAME) **** Relative Time: (TIME)"
        m = re.match(r"(.*) Thread-Metric(.+) Relative Time:\s*[0-9]+(.*)", line)
        if m:
            return self.parse_result
        else:
            self.errors.append(line)
            return self.test_failed

    def parse_result(self, line):
        # skip line: "tm_cooperative_thread_XXX : RESULT"
        m = re.match(r"tm_cooperative_thread_(.*): \d+", line)
        if m:
            return self.parse_result

        # match: "Time Period Total: (RESULT)"
        m = re.match(r"Time Period Total:[ ]*([0-9]+)", line)
        if m:
            self.measures.append(int(m.group(1)))
            return self.parse_measurement
        else:
            self.errors.append(line)
            return self.test_failed

    def test_failed(self, line):
        self.errors.append(line)
        return self.test_failed

    def do_parse(self):
        with open(self.logf) as f:
            line = next(f)
            action = self.parse_banner(line)
            for line in f:
                action = action(line)

        # if less than 3 measurements, fill with 0
        if (n_missing := 3 - len(self.measures)) > 0:
            self.measures.extend([0] * n_missing)


def parse_script_args():
    parser = argparse.ArgumentParser(
        description="create a thread metric report for the new arch_switch",
        epilog="Have a nice day",
    )

    parser.add_argument("reference", help="reference result (main)")
    parser.add_argument("arch_switch", help="new arch_switch result")
    args = parser.parse_args()
    return args


def parse_twister_out(twister_dir):
    for name in os.listdir(twister_dir):
        if os.path.isdir(os.path.join(twister_dir, name)):
            break
    platform = name
    test_dir = os.path.join(
        twister_dir, platform, "zephyr", "tests", "benchmarks", "thread_metric"
    )
    report = dict()
    for name in sorted(os.listdir(test_dir)):
        test_name = name.split(".")[-1]
        parser = LogParser(os.path.join(test_dir, name))
        parser.do_parse()
        report[test_name] = parser
    return (platform, report)


def stringify(meas):
    return " <br> ".join((f"{v:,}" for v in meas))


def create_report(ref, newer):
    p1, r1 = parse_twister_out(ref)
    p2, r2 = parse_twister_out(newer)
    if p1 != p2:
        print(f"platform does not match: {p1} != {p2}")
        return
    if r1.keys() != r2.keys():
        print(f"twister tests do not match: {r1.keys()} != {r2.keys()}")
        return

    print(f"platform: {p1}\n")
    print("| Test | ref (main) | new arch_switch | Improvement |")
    print("|:-----|-----------:|----------------:|:-----------:|")

    err_report = []
    errnum = 1
    for k in r1:
        ref_meas = r1[k].measures
        new_meas = r2[k].measures
        print(
            f"|TM_{k.upper()}|{stringify(ref_meas)}|{stringify(new_meas)}|",
            end="",
        )
        if r2[k].errors:
            print(f"see {errnum})|")
            err_report.append("".join(r2[k].errors))
            errnum += 1
        else:
            ratio = round(statistics.mean(new_meas) / statistics.mean(ref_meas), 3)-1
            print(f"{ratio*100:+.1f}%|")

    for n, err in enumerate(err_report, 1):
        print(f"\n{n}\\) error reported:")
        print(f"```\n{err}```")


def main():
    args = parse_script_args()
    create_report(args.reference, args.arch_switch)


if __name__ == "__main__":
    main()
