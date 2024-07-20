module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [2:0] state;

	always @(posedge clk) begin
		if (reset) begin
			state <= 3'b000;
		end else if (state == 3'b000) begin
			state <= 3'b001;
		end else if (state == 3'b001) begin
			state <= 3'b010;
		end else if (state == 3'b010) begin
			state <= 3'b011;
		end else if (state == 3'b011) begin
			state <= 3'b100;
		end else begin
			state <= 3'b101;
		end
	end

	assign shift_ena = (state == 3'b000) || (state == 3'b001) || (state == 3'b010) || (state == 3'b011);

endmodule
