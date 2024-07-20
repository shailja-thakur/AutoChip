module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);
	reg [1:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b00;
		else if (state == 2'b00 && s)
			state <= 2'b01;
		else if (state == 2'b01) begin
			if (w)
				state <= 2'b10;
			else
				state <= 2'b00;
		end
		else if (state == 2'b10) begin
			if (w)
				state <= 2'b11;
			else
				state <= 2'b01;
		end
		else if (state == 2'b11) begin
			if (w)
				state <= 2'b11;
			else
				state <= 2'b10;
		end
	end
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			z <= 1'b0;
		else if (state == 2'b11 && (w == 1 && #1 w == 1 || w == 0 && #1 w == 1 || w == 1 && #1 w == 0))
			z <= 1'b1;
		else
			z <= 1'b0;
	end
endmodule
