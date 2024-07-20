module top_module (
	input clk,
	input a, 
	output reg q
);

	always @(posedge clk) begin
		if (a == 0 && q == 1) begin
			q <= 1'b1;
		end else if (a == 1 && q == 0) begin
			q <= 1'b0;
		end
	end

endmodule
