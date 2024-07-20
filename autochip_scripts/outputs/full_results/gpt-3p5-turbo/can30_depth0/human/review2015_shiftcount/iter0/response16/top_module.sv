module top_module(
	input clk,
	input shift_ena,
	input count_ena,
	input data,
	output reg [3:0] q);
	
	always @(posedge clk) begin
		if (shift_ena)
			q <= {q[2:0], data};
		else if (count_ena)
			if (q === 4'b0000) 
				q <= 4'b1111;
			else
				q <= q - 1;
	end
	
endmodule
