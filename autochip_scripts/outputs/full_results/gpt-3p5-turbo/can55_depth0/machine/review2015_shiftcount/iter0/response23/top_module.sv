module top_module(
	input clk,
	input shift_ena,
	input count_ena,
	input data,
	output reg [3:0] q);

	always @(posedge clk) begin
		if(shift_ena)
			q <= data;   // shift data into q

		if(count_ena) begin
			if(q == 4'b0000)
				q <= 4'b1111;   // wrap around to 4'b1111 if q is 4'b0000
			else
				q <= q - 1;   // decrement q
		end
	end
	
endmodule
