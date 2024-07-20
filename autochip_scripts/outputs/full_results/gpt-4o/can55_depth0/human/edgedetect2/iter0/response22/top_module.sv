module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge
);

	reg [7:0] prev_in;
	
	always @(posedge clk) begin
		anyedge <= (in & ~prev_in); // Detect 0 to 1 transitions from the input
		prev_in <= in; // Store the current input value for comparison in the next clock cycle
	end
	
endmodule
