module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [1:0] count;
	reg shift_ena_reg;

	always @(posedge clk) begin
		if (reset) begin
			count <= 0;
			shift_ena_reg <= 1;
		end else if (shift_ena_reg && count < 3) begin
			count <= count + 1;
		end else if (shift_ena_reg && count == 3) begin
			shift_ena_reg <= 0;
		end
	end

	assign shift_ena = shift_ena_reg;

endmodule
