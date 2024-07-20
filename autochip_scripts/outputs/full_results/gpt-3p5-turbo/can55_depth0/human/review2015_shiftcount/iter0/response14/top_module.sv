module top_module(
	input clk,
	input shift_ena,
	input count_ena,
	input data,
	output reg [3:0] q);
	
	reg [3:0] shift_register;
	always @(posedge clk) begin
		if (shift_ena) begin
			shift_register[3:1] <= shift_register[2:0];
			shift_register[0] <= data;
		end
		
		if (count_ena) begin
			shift_register <= shift_register - 1;
		end
	end
	
	assign q = shift_register;
endmodule
