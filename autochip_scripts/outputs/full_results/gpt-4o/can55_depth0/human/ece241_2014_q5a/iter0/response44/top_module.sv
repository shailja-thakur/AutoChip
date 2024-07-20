module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	reg state, next_state;
  
	// State encoding
	localparam STATE_INVERT = 1'b0, // State to invert bits
			   STATE_ADD1 = 1'b1;   // State to add 1 to the inverted bits
  
	// State transition
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= STATE_INVERT;
		else
			state <= next_state;
	end
 
	// Next state logic
	always @(*) begin
		case (state)
			STATE_INVERT: next_state = STATE_ADD1;
			STATE_ADD1: next_state = STATE_ADD1; // Remain in ADD1 state after first bit is processed
			default: next_state = STATE_INVERT;
		endcase
	end
 
	// Output logic and register update
	always @(posedge clk or posedge areset) begin
		if (areset)
			z <= 1'b0;
		else begin
			case (state)
				STATE_INVERT: z <= ~x;
				STATE_ADD1: begin
					if (z == 1'b0)
						z <= 1'b1;
					else
						z <= 1'b0;
				end
				default: z <= 1'b0;
			endcase
		end
	end

endmodule
