module top_module(
	input clk,
	input reset,
	output [9:0] q);

	reg [9:0] counter;

	always @(posedge clk or posedge reset) begin
		if (reset)
			counter <= 0;
		else if (counter == 999)
			counter <= 0;
		else
			counter <= counter + 1;
	end

	assign q = counter;

endmodule
