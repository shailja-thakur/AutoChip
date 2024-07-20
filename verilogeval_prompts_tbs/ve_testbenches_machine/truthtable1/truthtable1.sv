//  This top Verilog module takes three input signals, x3, x2, and x1, and produces an output signal f. The output signal f is determined by the combination of the three input signals using a logical OR operation. The output signal f will be high if any of the following four combinations of the three input signals is true: (not x3 and x2 and not x1), (not x3 and x2 and x1), (x3 and not x2 and x1), or (x3 and x2 and x1). Otherwise, the output signal f will be low.

module top_module (
	input x3,
	input x2,
	input x1,
	output f
);
