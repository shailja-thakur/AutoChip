module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [2:0] count;
	reg shift_ena_reg;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			count <= 3'b0;
			shift_ena_reg <= 1'b1;
		end else if (count < 3'b100) begin
			count <= count + 1;
			shift_ena_reg <= 1'b0;
		end else begin
			count <= 3'b0;
			shift_ena_reg <= 1'b0;
		end
	end

	assign shift_ena = shift_ena_reg;

endmodule
