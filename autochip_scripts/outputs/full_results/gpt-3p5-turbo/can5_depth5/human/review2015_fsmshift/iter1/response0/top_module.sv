module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [3:0] count;
	// added reg to hold the shift_ena value
	reg shift_ena_reg;

	always @(posedge clk) begin
		if (reset) begin
			count <= 4'b0;
			shift_ena_reg <= 1'b1; // assert shift_ena for 4 cycles during reset
		end else if (count < 4'b0101) begin
			count <= count + 1;
			shift_ena_reg <= 1'b0; // deassert shift_ena after 4 cycles
		end else begin
			count <= 4'b0;
			shift_ena_reg <= 1'b0; // deassert shift_ena after 4 cycles
		end
	end

	// assign the value of shift_ena_reg to shift_ena
	assign shift_ena = shift_ena_reg;

endmodule
