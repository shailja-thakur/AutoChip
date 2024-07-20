module top_module (
	input clk,
	input reset,
	input x,
	output reg z
);

	// Internal state
	reg [2:0] state;
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b001; // Initialize state to A
		else begin
			// State transition logic
			case (state)
				3'b000: // State A
					if (x)
						state <= 3'b001; // Next state is B
					else
						state <= 3'b000; // Next state is A
				3'b001: // State B
					if (x)
						state <= 3'b100; // Next state is E
					else
						state <= 3'b001; // Next state is B
				3'b010: // State C
					if (x)
						state <= 3'b001; // Next state is B
					else
						state <= 3'b010; // Next state is C
				3'b011: // State D
					if (x)
						state <= 3'b010; // Next state is C
					else
						state <= 3'b001; // Next state is B
				3'b100: // State E
					if (x)
						state <= 3'b100; // Next state is E
					else
						state <= 3'b011; // Next state is D
				default: // Reset state to A if unknown state
					state <= 3'b001;
			endcase
		end
	end
	
	// Output logic
	always @(state) begin
		case (state)
			3'b011, 3'b100: // State D or E
				z <= 1'b1; // Output is high
			default:
				z <= 1'b0; // Output is low
		endcase
	end

endmodule
