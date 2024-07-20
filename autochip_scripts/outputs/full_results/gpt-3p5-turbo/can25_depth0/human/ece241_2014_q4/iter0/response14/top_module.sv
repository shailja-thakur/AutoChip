module top_module (
	input clk,
	input x,
	output z
);
	// Define the flip-flops
	reg d1, d2, d3;
	reg q1, q2, q3;

	// Define the gates
	wire xor_out;
	wire and_out;
	wire or_out;

	// Define the XNOR gate
	wire xnor_out;

	// Assign input x to the gates
	xor xor_gate(xor_out, x, q1);
	and and_gate(and_out, x, ~q2);
	or or_gate(or_out, x, ~q3);

	// Assign flip-flop outputs to the XNOR gate
	xnor xnor_gate(xnor_out, xor_out, and_out, or_out);

	// Assign XNOR gate output to z
	assign z = xnor_out;

	// Implement the flip-flops
	always @(posedge clk) begin
		q1 <= d1;
		q2 <= d2;
		q3 <= d3;
	end

	// Reset the flip-flops to zero
	initial begin
		d1 <= 1'b0;
		d2 <= 1'b0;
		d3 <= 1'b0;
	end
endmodule
module xor (
	output out,
	input in1,
	input in2
);
	assign out = in1 ^ in2;
endmodule
module and (
	output out,
	input in1,
	input in2
);
	assign out = in1 & in2;
endmodule
module or (
	output out,
	input in1,
	input in2
);
	assign out = in1 | in2;
endmodule
module xnor (
	output out,
	input in1,
	input in2,
	input in3
);
	assign out = ~(in1 ^ in2 ^ in3);
endmodule
