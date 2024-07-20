module top_module(
	output reg out);

	// Assign the output port to a constant value of 0
	always @(posedge clk or negedge rst) begin
		if (!rst)
			out <= 1'b0;
	end
	
endmodule
