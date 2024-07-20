module top_module (
	input clk,
	input a,
	output reg [2:0] q
);

	// State transitions
	always @(posedge clk) begin
		if (a) begin
			q <= 3'b100; // Set q to 4 when a is 1
		end else if (q == 3'b110) begin
			q <= 3'b000; // Set q to 0 when a is 0 and q is 6
		end else begin
			q <= q + 1'b1; // Increment q when a is 0 and q is not 6
		end
	end

endmodule
