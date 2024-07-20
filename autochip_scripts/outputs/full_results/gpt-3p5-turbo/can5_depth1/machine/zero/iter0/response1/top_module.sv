module top_module(
	output reg zero);

	always @(posedge clk) // Assuming there is a clock input
	begin
		zero <= 0;
	end

endmodule
