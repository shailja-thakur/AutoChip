module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [2:0] state;

	// State transition logic
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b000;
		else begin
			case (state)
				3'b000: state <= 3'b001;
				3'b001: state <= 3'b010;
				3'b010: state <= 3'b011;
				3'b011: state <= 3'b100;
				default: state <= 3'b100;
			endcase
		end
	end

	// Output logic
	assign shift_ena = (state == 3'b000) || (state == 3'b001) || (state == 3'b010) || (state == 3'b011);

endmodule
