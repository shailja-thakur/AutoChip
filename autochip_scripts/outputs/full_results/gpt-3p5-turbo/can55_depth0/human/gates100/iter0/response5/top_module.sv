module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);
// Instantiate AND, OR, and XOR gates
wire [99:0] and_inputs;
wire [99:0] or_inputs;
wire [99:0] xor_inputs;

and_gate and1 (
	.in(and_inputs),
	.out(out_and)
);

or_gate or1 (
	.in(or_inputs),
	.out(out_or)
);

xor_gate xor1 (
	.in(xor_inputs),
	.out(out_xor)
);

// Connect input wires to gate inputs
assign and_inputs = in;
assign or_inputs = in;
assign xor_inputs = in;

endmodule
module and_gate (
	input [99:0] in,
	output out
);
genvar i;
wire temp;

generate
	for (i = 0; i < 100; i=i+1) begin: and_gen
		and_gate_with_two_inputs and_gate_inst(
			.in1(in[i]),
			.in2(temp),
			.out(temp)
		);
	end
endgenerate

assign out = temp;
endmodule
module or_gate (
	input [99:0] in,
	output out
);
genvar i;
wire temp;

generate
	for (i = 0; i < 100; i=i+1) begin: or_gen
		or_gate_with_two_inputs or_gate_inst(
			.in1(in[i]),
			.in2(temp),
			.out(temp)
		);
	end
endgenerate

assign out = temp;
endmodule
module xor_gate (
	input [99:0] in,
	output out
);
genvar i;
wire temp;

generate
	for (i = 0; i < 100; i=i+1) begin: xor_gen
		xor_gate_with_two_inputs xor_gate_inst(
			.in1(in[i]),
			.in2(temp),
			.out(temp)
		);
	end
endgenerate

assign out = temp;
endmodule
module and_gate_with_two_inputs (
	input in1,
	input in2,
	output out
);
assign out = in1 & in2;
endmodule
module or_gate_with_two_inputs (
	input in1,
	input in2,
	output out
);
assign out = in1 | in2;
endmodule
module xor_gate_with_two_inputs (
	input in1,
	input in2,
	output out
);
assign out = in1 ^ in2;
endmodule
