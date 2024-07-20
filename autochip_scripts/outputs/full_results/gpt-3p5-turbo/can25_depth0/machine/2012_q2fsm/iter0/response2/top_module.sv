module top_module (
	input clk,
	input reset,
	input w,
	output reg z // Output z is defined as a registered output
);

	reg [2:0] state; // 3-bit register to represent the states

	always @ (posedge clk or posedge reset) begin // Synchronous reset
		if (reset)
			state <= 3'b000; // Reset to initial state A
		else begin
			// State transitions based on w and current state
			case ({w, state})
				3'b0_000, 3'b0_001, 3'b0_100: state <= 3'b000;
				3'b0_010, 3'b0_011: state <= 3'b100;
				3'b0_101: state <= 3'b100;
				3'b0_110: state <= 3'b100;
				3'b1_000: state <= 3'b010;
				3'b1_001: state <= 3'b001;
				3'b1_010: state <= 3'b011;
				3'b1_011: state <= 3'b100;
				3'b1_100: state <= 3'b010;
				3'b1_101: state <= 3'b010;
				3'b1_110: state <= 3'b011;
				default: state <= 3'b000;
			endcase
		end
	end

	assign z = (state == 3'b100 || state == 3'b011); // Output z is set to 1 when in state E or F

endmodule
