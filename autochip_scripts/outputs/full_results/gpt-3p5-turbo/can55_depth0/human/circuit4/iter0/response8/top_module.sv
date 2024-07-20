module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);

	// Define internal signals
	wire w1, w2, w3, w4, w5, w6, w7, w8, w9;

	// Define gates
	and_gate u1 (.in1(a), .in2(d), .out(w1));
	or_gate u2 (.in1(c), .in2(w1), .out(w2));
	or_gate u3 (.in1(b), .in2(w1), .out(w3));
	or_gate u4 (.in1(w2), .in2(w3), .out(w4));
	nor_gate u5 (.in1(w4), .out(w5));
	or_gate u6 (.in1(c), .in2(b), .out(w6));
	and_gate u7 (.in1(a), .in2(w6), .out(w7));
	and_gate u8 (.in1(w5), .in2(w7), .out(w8));
	and_gate u9 (.in1(d), .in2(w8), .out(w9));

	// Define output
	assign q = w9;

endmodule
module and_gate (
	input in1,
	input in2,
	output out
);
	assign out = in1 & in2;
endmodule
module or_gate (
	input in1,
	input in2,
	output out
);
	assign out = in1 | in2;
endmodule
module nor_gate (
	input in1,
	output out
);
	assign out = ~(in1);
endmodule
