module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [3:0] count;

	always @(posedge clk) begin
		if (reset)
			count <= 4'b0;
		else begin
			if (count < 4)
				count <= count + 1;
			else
				count <= 4'b0;
		end
	end
	
	assign shift_ena = (count < 4'b4) & reset;

endmodule
