//  This module takes two input signals, in1 and in2, and produces a single output signal, out. The output signal is the logical AND of in1 and the logical NOT of in2. This means that the output signal will be high (1) only when in1 is high (1) and in2 is low (0). If either in1 or in2 is low (0), the output signal will be low (0). This module is used to perform logical operations on two input signals to produce a single output signal.

module top_module (
	input in1,
	input in2,
	output logic out
);
