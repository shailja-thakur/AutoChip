module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);
	
	wire [99:0] and_temp;
	wire [99:0] or_temp;
	
	// AND gate
	and and_gate (
		.in(in),
		.out(and_temp)
	);
	
	// OR gate
	or or_gate (
		.in(in),
		.out(or_temp)
	);
	
	// XOR gate
	xor xor_gate (
		.in(in),
		.out(out_xor)
	);
	
	assign out_and = and_temp[0];
	assign out_or = or_temp[0];
endmodule
module and (
	input [99:0] in,
	output [99:0] out
);
	genvar i;
	
	generate
		for (i=0; i<100; i=i+1) begin: and_gen
			assign out[i] = in[i];
		end
	endgenerate
endmodule
module or (
	input [99:0] in,
	output [99:0] out
);
	genvar i;
	
	generate
		for (i=0; i<100; i=i+1) begin: or_gen
			assign out[i] = in[i];
		end
	endgenerate
endmodule
module xor (
	input [99:0] in,
	output [99:0] out
);
	genvar i;
	
	generate
		for (i=0; i<100; i=i+1) begin: xor_gen
			assign out[i] = in[i];
		end
	endgenerate
endmodule
