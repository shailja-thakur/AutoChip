module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [3:0] counter;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			counter <= 4'b0000;
			shift_ena <= 1'b1;
		end else begin
			if (counter == 4'b1111)
				shift_ena <= 1'b0;

			if (shift_ena)
				counter <= counter + 1'b1;
		end
	end

endmodule
