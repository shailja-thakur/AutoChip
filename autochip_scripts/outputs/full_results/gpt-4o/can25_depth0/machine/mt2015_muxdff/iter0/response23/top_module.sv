module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q);

	// Initialize the output register Q to 0
	initial Q = 0;

	// Always block, triggered on the rising edge of the clock signal
	always @(posedge clk) begin
		if (L)
			Q <= r_in;
		else
			Q <= q_in;
	end

endmodule
