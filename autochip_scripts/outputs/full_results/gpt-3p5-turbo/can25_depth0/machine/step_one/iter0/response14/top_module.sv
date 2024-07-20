module top_module(
	output reg one);

	always @(posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			one <= 1'b0;
		end else begin
			one <= 1'b1;
		end
	end
endmodule
