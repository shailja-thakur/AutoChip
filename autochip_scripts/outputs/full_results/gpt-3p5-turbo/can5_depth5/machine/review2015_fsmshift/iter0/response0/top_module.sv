module top_module(
	input clk,
	input reset,
	output shift_ena);
	
	reg [2:0] state;
	
	// State transition logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 3'b000; // Reset to B0
		end else begin
			case(state)
				3'b000: state <= shift_ena ? 3'b001 : 3'b111; // B0 to B1 if shift_ena is enabled, else Done
				3'b001: state <= shift_ena ? 3'b010 : 3'b111; // B1 to B2 if shift_ena is enabled, else Done
				3'b010: state <= shift_ena ? 3'b011 : 3'b111; // B2 to B3 if shift_ena is enabled, else Done
				3'b011: state <= shift_ena ? 3'b100 : 3'b111; // B3 to Done if shift_ena is enabled, else Done
				default: state <= 3'b111; // In case of any other state, transition to Done
			endcase
		end
	end
	
	// Set shift_ena output
	assign shift_ena = (state == 3'b000) || (state == 3'b001) || (state == 3'b010) || (state == 3'b011);

endmodule
