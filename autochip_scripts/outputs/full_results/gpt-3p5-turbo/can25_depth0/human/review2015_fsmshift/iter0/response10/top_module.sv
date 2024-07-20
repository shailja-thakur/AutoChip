module top_module(
        input clk,
        input reset,
        output reg shift_ena);

	reg [3:0] counter;

	always @(posedge clk) begin
		if (reset)
			counter <= 4'b0000;
		else if (counter == 4'b1100)
			counter <= 4'b0000;
		else if (counter < 4'b1100)
			counter <= counter + 1;
		end

	assign shift_ena = (counter == 4'b1100);

endmodule
