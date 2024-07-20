module top_module(
	output reg one);

	always @(posedge clk or negedge reset) begin
		if (reset)
			one <= 1'b0;
		else
			one <= 1'b1;
	end

endmodule
