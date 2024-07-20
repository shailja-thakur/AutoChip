module top_module (
	input clk,
	input x,
	output z
);
	// Declare all flip-flops
	reg dff1, dff2, dff3;

	// Declare all intermediate signals
	wire xor_out, and_out, or_out, xnor_out;

	// DFF1
	always @(posedge clk)
	begin
		if (rst)
			dff1 <= 1'b0;
		else
			dff1 <= x ^ dff1;
	end

	// DFF2
	always @(posedge clk)
	begin
		if (rst)
			dff2 <= 1'b0;
		else
			dff2 <= x & ~dff2;
	end

	// DFF3
	always @(posedge clk)
	begin
		if (rst)
			dff3 <= 1'b0;
		else
			dff3 <= x | ~dff3;
	end

	// XOR gate
	assign xor_out = x ^ dff1;

	// AND gate
	assign and_out = x & ~dff2;

	// OR gate
	assign or_out = x | ~dff3;

	// XNOR gate
	assign xnor_out = xor_out ^ and_out ^ or_out;

	// Output Z
	assign z = xnor_out;

endmodule
