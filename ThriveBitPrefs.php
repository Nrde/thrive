<?php
// Thrive BitPrefs - Stores boolean preferences into a bit mask.
// This file is a part of the Thrive Framework, a PHPExperts.pro Project.
//
// Copyright (c) 2012 Theodore R.Smith (theodore@phpexperts.pro)
// DSA-1024 Fingerprint: 10A0 6372 9092 85A2 BB7F  907B CB8B 654B E33B F1ED
// Provided by the PHP University (www.phpu.cc) and PHPExperts.pro (www.phpexperts.pro)
//
// This file is dually licensed under the terms of the following licenses:
// * Primary License: OSSAL v1.0 - Open Source Software Alliance License
//   * Key points:
//       5.Redistributions of source code in any non-textual form (i.e.
//          binary or object form, etc.) must not be linked to software that is
//          released with a license that requires disclosure of source code
//          (ex: the GPL).
//       6.Redistributions of source code must be licensed under more than one
//          license and must not have the terms of the OSSAL removed.
//   * See LICENSE.ossal for complete details.
//
// * Secondary License: Creative Commons Attribution License v3.0
//   * Key Points:
//       * You are free:
//           * to copy, distribute, display, and perform the work
//           * to make non-commercial or commercial use of the work in its original form
//       * Under the following conditions:
//           * Attribution. You must give the original author credit. You must retain all
//             Copyright notices and you must include the sentence, "Based upon work from
//             PHPExperts.pro (www.phpexperts.pro).", wherever you list contributors.
//   * See LICENSE.cc_by for complete details.

class Thrive_BitPrefs
{
	protected $prefsMask;

	public function __construct($prefsMask = 0)
	{
		$this->prefsMask = $prefsMask;
	}

	public function clear() { $this->prefsMask = 0; }

	public function isOn($pref)
	{
		$s = ($this->prefsMask & $pref) === $pref;
		return ($s === false ? 'Off' : 'On') . "\n";
	}

	public function turnOn($pref)
	{
		$this->prefsMask |= $pref;
	}

	public function turnOff($pref)
	{
		$this->prefsMask &= ~$pref;
	}
}

