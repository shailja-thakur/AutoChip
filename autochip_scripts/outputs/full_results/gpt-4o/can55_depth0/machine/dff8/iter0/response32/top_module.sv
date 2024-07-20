module top_module(
	input clk,
	input [7:0] d,
	output reg [7:0] q);
	
	// Initialize the output register q to 0
	initial begin
		q = 8'h00;
	end

	// Always block triggered on the rising edge of the clock
	always @(posedge clk) begin
		q <= d; // On each rising edge of the clock, store input d into q
	end
	
endmodule
