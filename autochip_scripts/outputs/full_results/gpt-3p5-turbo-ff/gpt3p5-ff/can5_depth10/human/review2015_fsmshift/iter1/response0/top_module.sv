module top_module(
	input clk,
	input reset,
	output reg shift_ena);

	reg [3:0] count;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			count <= 0;
			shift_ena <= 1;
		end else begin
			if (count < 4) begin
				count <= count + 1;
				shift_ena <= 1;
			end else if(count == 4) begin
				count <= count + 1;
				shift_ena <= 0;
			end else begin
				count <= count + 1;
				shift_ena <= shift_ena;
			end
		end
	end

endmodule
