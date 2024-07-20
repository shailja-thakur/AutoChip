module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

	reg [7:0] prev_in;

	always @(posedge clk) begin
		//Detect any edge and assign the edges to the output
		anyedge <= (in ^ prev_in) & in;
		//Store the current input to compare in the next clock cycle
		prev_in <= in;
	end

endmodule
