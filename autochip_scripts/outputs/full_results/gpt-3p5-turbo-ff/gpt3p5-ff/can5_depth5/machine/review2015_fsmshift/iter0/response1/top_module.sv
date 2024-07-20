module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [2:0] state_reg;
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state_reg <= 3'b000;
		end else begin
			if (state_reg == 3'b000) begin
				state_reg <= 3'b001;
			end else if (state_reg == 3'b001) begin
				state_reg <= 3'b010;
			end else if (state_reg == 3'b010) begin
				state_reg <= 3'b011;
			end else if (state_reg == 3'b011) begin
				state_reg <= 3'b100;
			end else begin
				state_reg <= 3'b100;
			end
		end
	end

	assign shift_ena = (state_reg == 3'b000) || (state_reg == 3'b001) || (state_reg == 3'b010) || (state_reg == 3'b011);
	
endmodule
