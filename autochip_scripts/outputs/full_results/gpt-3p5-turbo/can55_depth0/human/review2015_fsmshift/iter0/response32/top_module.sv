module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [3:0] counter;
	reg shift_ena;

	always @(posedge clk) begin
		if (reset == 1'b1) begin
			counter <= 4'b0;
			shift_ena <= 1'b1;
		end else begin
			if (counter == 4'b1111) begin
				shift_ena <= 1'b0;
			end else begin
				shift_ena <= 1'b1;
				counter <= counter + 1'b1;
			end
		end
	end

endmodule
