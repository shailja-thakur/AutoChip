module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

	reg [7:0] in_delayed;
	
	always @(posedge clk) begin
		in_delayed <= in;             // Save the current input value for the next clock cycle
		anyedge <= (in_delayed ^ in); // Detect any edge (both rising and falling)
	end

endmodule
