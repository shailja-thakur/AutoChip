module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	// Define a wire to store the next value of q
	wire [3:0] next_q;

	// Always block triggered on the positive edge of clk
	always @(posedge clk) begin
		// If reset is asserted or q is equal to 9, reset q to 0
		if (reset || (q == 9)) begin
			next_q <= 4'b0000;
		end
		// Otherwise, increment q by 1
		else begin
			next_q <= q + 1;
		end
	end

	// Assign next_q to q
	always @(next_q) begin
		q <= next_q;
	end

endmodule
