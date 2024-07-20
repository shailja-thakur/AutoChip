module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg shift_ena_reg;
	always @(posedge clk or posedge reset)
	begin
		if (reset)
			shift_ena_reg <= 1;
		else if (shift_ena_reg)
			shift_ena_reg <= 0;
	end

	always @(posedge clk)
	begin
		if (reset)
			shift_ena <= 1;
		else if (shift_ena_reg)
			shift_ena <= 1;
		else
			shift_ena <= 0;
	end
	
endmodule
