module top_module(
	output reg zero);

	always @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			zero <= 0;
		end
	end
endmodule
