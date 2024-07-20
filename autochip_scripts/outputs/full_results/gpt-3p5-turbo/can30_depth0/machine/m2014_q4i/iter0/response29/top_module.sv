module top_module(
	output reg out);

	always @(posedge clk or negedge reset) begin
		if (reset == 1'b0) begin
			out <= 1'b0;  // Assign the output port to a constant value of 0
		end
	end

endmodule
