module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] anyedge);

	// declare internal signal to store previous value of input
	reg [7:0] prev_in;

	// always block to detect edges
	always @(posedge clk) begin
		// loop through all bits of the input vector
		for (integer i = 0; i < 8; i = i + 1) begin
			// check if current bit has changed from 0 to 1
			if (in[i] && !prev_in[i])
				anyedge[i] <= 1;
			else
				anyedge[i] <= 0;
		end
		// store current value of input in prev_in
		prev_in <= in;
	end

endmodule
