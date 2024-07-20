module top_module(
    input clk,
    input reset,
    output reg shift_ena);

	reg [2:0] state;

	always @(posedge clk) begin
		if (reset == 1)
			state <= 3'b0;
		else if (state == 3'b0)
			state <= 3'b1;
		else if (state == 3'b1)
			state <= 3'b10;
		else if (state == 3'b10)
			state <= 3'b11;
		else if (state == 3'b11)
			state <= 3'b100;
		else
			state <= 3'b100;
	end

	assign shift_ena = (state == 3'b0 || state == 3'b1 || state == 3'b10 || state == 3'b11) ? 1'b1 : 1'b0;

endmodule
