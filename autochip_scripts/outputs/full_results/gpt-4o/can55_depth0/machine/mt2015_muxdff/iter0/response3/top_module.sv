module top_module(
	input clk,
	input L,
	input q_in,
	input r_in,
	output reg Q);

	// Initialize output register Q to 0
	initial begin
		Q = 0;
	end

	// Triggered on the rising edge of the clock signal
	always @(posedge clk) begin
		if (L) begin
			Q = r_in;
		end else begin
			Q = q_in;
		end
	end

endmodule
