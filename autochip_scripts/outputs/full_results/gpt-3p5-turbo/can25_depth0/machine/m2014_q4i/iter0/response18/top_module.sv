module top_module(
	output reg out);

	// Assign output to 0
	always @(posedge clk) begin
		out <= 1'b0;
	end
endmodule
