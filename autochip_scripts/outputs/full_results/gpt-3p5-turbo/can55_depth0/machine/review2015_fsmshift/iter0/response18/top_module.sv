module top_module(
	input clk,
	input reset,
	output shift_ena);

	reg [2:0] state;
	always @(posedge clk) begin
		if (reset) begin
			state <= 3'b000;
		end else begin
			case (state)
				2'b00: state <= shift_ena ? 2'b01 : 2'b11; // B0 -> B1 or Done
				2'b01: state <= shift_ena ? 2'b10 : 2'b11; // B1 -> B2 or Done
				2'b10: state <= shift_ena ? 2'b11 : 2'b11; // B2 -> B3 or Done
				2'b11: state <= shift_ena ? 2'b11 : 2'b11; // B3 -> B3 or Done
			endcase
		end
	end
	
	assign shift_ena = state != 2'b11;

endmodule
