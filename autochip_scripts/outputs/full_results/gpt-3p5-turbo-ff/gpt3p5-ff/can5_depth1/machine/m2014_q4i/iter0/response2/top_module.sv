module top_module(
	output reg out);
	
	// Assign the output port to a constant value of 0
	always @(posedge clk or negedge rst_n) begin
		if (!rst_n)
			out <= 0;
		end
	endmodule
