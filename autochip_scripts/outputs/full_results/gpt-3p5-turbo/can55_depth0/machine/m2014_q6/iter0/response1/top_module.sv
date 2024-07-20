module top_module (
		input clk,
		input reset,
		input w,
		output reg z
	);
	
	// Declare internal state variable
	reg [2:0] state;
	
	// Initialize state to A on reset
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 3'b000; // A
		else begin
			// Determine next state based on current state and input w
			case (state)
				3'b000: // A
					if (w)
						state <= 3'b000; // A
					else
						state <= 3'b001; // B
				3'b001: // B
					if (w)
						state <= 3'b001; // B
					else
						state <= 3'b010; // C
				3'b010: // C
					if (w)
						state <= 3'b011; // D
					else
						state <= 3'b010; // C
				3'b011: // D
					if (w)
						state <= 3'b000; // A
					else
						state <= 3'b101; // F
				3'b101: // F
					if (w)
						state <= 3'b011; // D
					else
						state <= 3'b010; // C
				3'b011: // E
					if (w)
						state <= 3'b011; // D
					else
						state <= 3'b011; // E
				default:
					state <= 3'b000; // A
			endcase
		end
	end
	
	// Output z is high when state is E or F
	always @(state) begin
		if (state == 3'b011 || state == 3'b101)
			z = 1'b1;
		else
			z = 1'b0;
	end

endmodule
