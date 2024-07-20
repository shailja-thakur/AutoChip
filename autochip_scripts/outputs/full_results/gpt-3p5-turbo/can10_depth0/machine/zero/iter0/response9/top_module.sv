module top_module(
	output reg zero);

	always @(posedge clk) begin
		zero <= 1'b0;
	end
endmodule
