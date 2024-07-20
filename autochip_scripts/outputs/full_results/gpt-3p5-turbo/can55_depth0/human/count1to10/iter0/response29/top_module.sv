module top_module(
	input clk,
	input reset,
	output reg [3:0] q);

	// Define internal signals
	reg [3:0] count;

	// Synchronous reset
	always @(posedge clk or posedge reset)
	begin
		if (reset)
			count <= 4'b0001;
		else if (count == 4'b1010)
			count <= 4'b0001;
		else
			count <= count + 1;
	end

	// Assign outputs
	assign q = count;

endmodule
