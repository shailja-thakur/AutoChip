module top_module(
	input clk,
	input d,
	output reg q);
	
	reg d_pos, d_neg;

	always @(posedge clk) begin
		d_pos <= d;
	end

	always @(negedge clk) begin
		d_neg <= d;
	end

	always @(posedge clk or negedge clk) begin
		if (clk == 1'b1) begin
			q <= d_pos;
		end else begin
			q <= d_neg;
		end
	end
	
endmodule
