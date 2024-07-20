module top_module(
	input clk,
	input shift_ena,
	input count_ena,
	input data,
	output reg [3:0] q);
	
	reg [3:0] temp;
	
	always @(posedge clk) begin
		if (shift_ena) begin
			temp[3] <= data;
			temp[2] <= temp[3];
			temp[1] <= temp[2];
			temp[0] <= temp[1];
		end
		if (count_ena) begin
			if (shift_ena) begin
				temp <= temp - 1;
			end
			else begin
				temp <= temp;
			end
		end
	end
	
	always @(posedge clk) begin
		q <= temp;
	end
endmodule
