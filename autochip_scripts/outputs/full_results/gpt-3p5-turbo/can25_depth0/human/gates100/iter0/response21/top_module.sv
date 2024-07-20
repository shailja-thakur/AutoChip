module top_module (
	input [99:0] in,
	output out_and,
	output out_or,
	output out_xor
);

	// AND gate instantiation
	and_gate and1(
		.input(in),
		.output(out_and)
	);

	// OR gate instantiation
	or_gate or1(
		.input(in),
		.output(out_or)
	);

	// XOR gate instantiation
	xor_gate xor1(
		.input(in),
		.output(out_xor)
	);

endmodule
module and_gate (
	input [99:0] input,
	output reg out
);

	always @* begin
		out = 1'b1;
		for (int i = 0; i < 100; i = i + 1) begin
			out = out & input[i];
		end
	end

endmodule
module or_gate (
	input [99:0] input,
	output reg out
);

	always @* begin
		out = 1'b0;
		for (int i = 0; i < 100; i = i + 1) begin
			out = out | input[i];
		end
	end

endmodule
module xor_gate (
	input [99:0] input,
	output reg out
);

	always @* begin
		out = input[0];
		for (int i = 1; i < 100; i = i + 1) begin
			out = out ^ input[i];
		end
	end

endmodule
