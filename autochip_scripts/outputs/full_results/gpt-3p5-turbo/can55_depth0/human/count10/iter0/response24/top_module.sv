module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	// Register to hold the current value of the counter
	reg [3:0] count;

	always @(posedge clk) begin
		if (reset) begin
			count <= 0;
		end else begin
			if (count == 9) begin
				count <= 0;
			else
				count <= count + 1;
			end
		end
	end

	assign q = count;

endmodule
