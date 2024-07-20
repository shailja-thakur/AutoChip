module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);
	wire [99:0] and_out;
	wire [99:0] or_out;
	wire [99:0] xor_out;
	
	and_gate and_g1(.in(in), .out(and_out));
	or_gate or_g1(.in(in), .out(or_out));
	xor_gate xor_g1(.in(in), .out(xor_out));
	
	assign out_and = and_out[99];
	assign out_or = or_out[99];
	assign out_xor = xor_out[99];

endmodule
module and_gate (
	input [99:0] in,
	output [99:0] out
);
	generate
		for (genvar i = 0; i < 100; i++) begin : gates
			and_gate_single and_g1(.in(in[i]), .out(out[i]));
		end
	endgenerate
endmodule
module and_gate_single (
	input in,
	output out
);
	assign out = in;
endmodule
module or_gate (
	input [99:0] in,
	output [99:0] out
);
	generate
		for (genvar i = 0; i < 100; i++) begin : gates
			or_gate_single or_g1(.in(in[i]), .out(out[i]));
		end
	endgenerate
endmodule
module or_gate_single (
	input in,
	output out
);
	assign out = in;
endmodule
module xor_gate (
	input [99:0] in,
	output [99:0] out
);
	generate
		for (genvar i = 0; i < 100; i++) begin : gates
			xor_gate_single xor_g1(.in(in[i]), .out(out[i]));
		end
	endgenerate
endmodule
module xor_gate_single (
	input in,
	output out
);
	assign out = in;
endmodule
