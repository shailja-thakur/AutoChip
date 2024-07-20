module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [3:0] counter;
	reg shift_ena_reg;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			counter <= 4'b0000;
			shift_ena_reg <= 1'b1;
		end else begin
			if (counter < 4'b0100) begin
				counter <= counter + 1'b1;
				shift_ena_reg <= 1'b1;
			end else begin
				counter <= counter + 1'b1;
				shift_ena_reg <= 1'b0;
			end
		end
	end

	assign shift_ena = shift_ena_reg;

endmodule
