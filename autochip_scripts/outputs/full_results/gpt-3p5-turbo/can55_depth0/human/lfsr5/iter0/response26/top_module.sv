module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	// Define internal signals
	reg [4:0] lfsr;
	reg feedback;

	// Synchronous reset
	always @(posedge clk or posedge reset)
		if (reset)
			lfsr <= 5'b1;
		else begin
			feedback <= lfsr[4] ^ lfsr[2];
			lfsr <= {lfsr[3:0], feedback};
		end

	// Output assignment
	assign q = lfsr;

endmodule
