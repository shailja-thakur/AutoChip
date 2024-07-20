module top_module (
	input clk,
	input x,
	output z
);

	// Declare D flip-flops
	reg d_ff1;
	reg d_ff2;
	reg d_ff3;

	// Declare combinational logic signals
	wire xor_out;
	wire and_out;
	wire or_out;

	// Declare XNOR output
	assign z = ~(xor_out ^ and_out ^ or_out);

	// Connect input x to gates
	xor xor_gate(x, d_ff1, xor_out);
	and and_gate(x, ~d_ff2, and_out);
	or or_gate(x, ~d_ff3, or_out);

	// Flip-flop 1
	always @(posedge clk) begin
		if (x)
			d_ff1 <= 1;
		else
			d_ff1 <= 0;
	end

	// Flip-flop 2
	always @(posedge clk) begin
		if (x)
			d_ff2 <= 1;
		else
			d_ff2 <= 0;
	end
	
	// Flip-flop 3
	always @(posedge clk) begin
		if (x)
			d_ff3 <= 1;
		else
			d_ff3 <= 0;
	end
endmodule
module xor(
	input a,
	input b,
	output y
);
	assign y = a ^ b;
endmodule
module and(
	input a,
	input b,
	output y
);
	assign y = a & b;
endmodule
module or(
	input a,
	input b,
	output y
);
	assign y = a | b;
endmodule
