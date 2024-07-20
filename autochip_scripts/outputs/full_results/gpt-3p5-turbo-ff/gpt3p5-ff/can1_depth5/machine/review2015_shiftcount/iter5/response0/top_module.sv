module top_module(
	input clk,
	input shift_ena,
	input count_ena,
	input data,
	output reg [3:0] q);

	reg [3:0] q_next;

	always @(posedge clk or posedge shift_ena) begin
		if(shift_ena)
			q_next <= data;
		else if(count_ena)
			q_next <= q - 1;
		else
			q_next <= q;
	end
	
	always @(posedge clk) begin
		q <= q_next;
	end

endmodule
