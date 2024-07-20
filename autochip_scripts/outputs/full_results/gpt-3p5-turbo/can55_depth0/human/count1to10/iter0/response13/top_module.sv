module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	// Internal signal to hold the current count value
	reg [3:0] count;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			count <= 4'b0001; // Reset the counter to 1
		end else begin
			// Increment the counter
			if (count == 4'b1010) begin
				count <= 4'b0000;
			end else begin
				count <= count + 1;
			end
		end
	end

	assign q = count;

endmodule
