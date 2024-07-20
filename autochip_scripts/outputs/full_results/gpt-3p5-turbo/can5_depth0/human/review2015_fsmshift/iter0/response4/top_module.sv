module top_module(
	input clk,
	input reset,
	output reg shift_ena);
	
	reg [3:0] count;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			count <= 4'b1111;
		end else begin
			if (count > 0) begin
				count <= count - 1;
			end
		end
	end

	assign shift_ena = (count > 0);

endmodule
