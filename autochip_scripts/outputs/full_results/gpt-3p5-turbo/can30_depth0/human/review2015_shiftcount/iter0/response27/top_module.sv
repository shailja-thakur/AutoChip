module top_module(
	input clk,
	input shift_ena,
	input count_ena,
	input data,
	output reg [3:0] q);

	always @(posedge clk) begin
		if (shift_ena && !count_ena) begin
			q <= {data, q[3:1]};
		end else if (!shift_ena && count_ena) begin
			if (q == 0) begin
				q <= 4'b1111;
			end else begin
				q <= q - 1;
			end
		end else begin
			// do nothing when shift_ena and count_ena are both 1
		end
	end
	
endmodule
