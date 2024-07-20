module top_module(
	input clk,
	input shift_ena,
	input count_ena,
	input data,
	output reg [3:0] q);
	
	always @(posedge clk) begin
		if (shift_ena) begin
			q <= {data, q[3:1]};
		end else if (count_ena) begin
			if (q == 4'd0) begin
				q <= 4'd15;
			else begin
				q <= q - 1;
			end
		end
	end
endmodule
