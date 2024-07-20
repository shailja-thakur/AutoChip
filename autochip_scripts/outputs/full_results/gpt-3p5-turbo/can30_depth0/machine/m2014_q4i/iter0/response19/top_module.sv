module top_module(
	output reg out);

	always @(posedge clk or negedge rst_n)
	begin
		if (!rst_n)
			out <= 1'b0;
		else
			out <= 1'b0;
	end

endmodule
