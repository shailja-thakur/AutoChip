module top_module (
	input in1,
	input in2,
	input in3,
	output logic out
);
	
	xnor #(2) u1 (.a(in1), .b(in2), .z(xnor_out));
	xor #(2) u2 (.a(xnor_out), .b(in3), .z(out));

endmodule
