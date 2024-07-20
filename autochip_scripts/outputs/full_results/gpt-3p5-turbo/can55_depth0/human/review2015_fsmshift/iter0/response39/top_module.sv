module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [3:0] counter;
	reg shift_ena;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			shift_ena <= 1;
			counter <= 4'b0000;
		end else begin
			if (counter < 4'b0100) begin
				shift_ena <= 1;
				counter <= counter + 1;
			end else begin
				shift_ena <= 0;
			end
		end
	end

endmodule
