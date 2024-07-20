module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	reg [3:0] count;
	reg [7:0] pattern;
	reg enable;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			shift_ena <= 1'b0;
			count <= 0;
		end
		else begin
			if (count == 4'b1000 && enable) begin
				shift_ena <= 1'b0;
			end
			else begin
				shift_ena <= enable;
			end
			
			if (count == 4'b1000 || reset) begin
				count <= 4'b0000;
				enable <= (pattern == 8'b11001010); // set your desired bit pattern here
			end
			else begin
				count <= count + 1;
				pattern <= pattern << 1;
			end
		end
	end
endmodule
