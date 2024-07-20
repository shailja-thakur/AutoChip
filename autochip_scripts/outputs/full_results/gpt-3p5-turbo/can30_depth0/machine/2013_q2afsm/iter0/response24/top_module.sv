module top_module (
	input clk,
	input resetn,
	input [2:0] r,
	output [2:0] g
);
	// Declare state register
	reg [1:0] state;

	// Assign g based on current state
	always @ (state)
	begin
		case (state)
			2'b00: g = 3'b000; // State A, g is all low
			2'b01: g = {1'b1, 2'b00}; // State B, g[1] is high
			2'b10: g = {1'b0, 1'b1, 1'b0}; // State C, g[2] is high
			2'b11: g = {1'b0, 1'b0, 1'b1}; // State D, g[3] is high
			default: g = 3'b000; // Should never happen
		endcase
	end

	// State register update
	always @ (posedge clk or negedge resetn)
	begin
		if (~resetn)
			state <= 2'b00; // Reset state is A
		else
		begin
			case (state)
				2'b00: state <= r[1] ? 2'b01 : (r[2] ? 2'b10 : (r[3] ? 2'b11 : 2'b00)); // Update next state based on r
				2'b01: state <= r[1] ? 2'b01 : 2'b00; // Update next state based on r
				2'b10: state <= r[2] ? 2'b10 : 2'b00; // Update next state based on r
				2'b11: state <= r[3] ? 2'b11 : 2'b00; // Update next state based on r
				default: state <= 2'b00; // Should never happen
			endcase
		end
	end
endmodule
