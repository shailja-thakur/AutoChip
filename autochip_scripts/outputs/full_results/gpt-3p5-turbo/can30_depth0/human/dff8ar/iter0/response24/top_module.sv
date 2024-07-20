module top_module(
	input clk,
	input [7:0] d,
	input areset,
	output reg [7:0] q);

	reg [7:0] q_internal;  // internal register to store intermediate values

	// Assign the output 'q' to 'q_internal' for synchronization
	always @(posedge clk or posedge areset)
		begin
			if (areset)
				q_internal <= 8'b0;
			else
				q_internal <= d;
		end

	// Assign the synchronized 'q_internal' to the output 'q'
	always @(posedge clk)
		begin
			q <= q_internal;
		end

endmodule
