module top_module(
	input clk,
	input reset,
	output reg [4:0] q);

	// Define internal signals
	reg [4:0] lfsr;

	// Always block for synchronous reset
	always @(posedge clk) begin
		if (reset)
			lfsr <= 5'h1;
		else begin
			lfsr[4] <= lfsr[3] ^ lfsr[2];
			lfsr[3:0] <= lfsr[4:1];
		end
	end

	// Assign output
	assign q = lfsr;
	
endmodule
