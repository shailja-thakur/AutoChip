module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// State declaration
	typedef enum reg [1:0] {
		START = 2'b00,
		NON_INVERT = 2'b01,
		INVERT = 2'b10
	} state_t;
	
	state_t state, next_state;

	// State transition logic (Moore FSM)
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= START;
		else
			state <= next_state;
	end

	// Next state logic
	always @(*) begin
		case (state)
			START: 
				if (x == 1'b1)
					next_state = INVERT;
				else
					next_state = NON_INVERT;
				
			NON_INVERT:
				if (x == 1'b1)
					next_state = INVERT;
				else
					next_state = NON_INVERT;
					
			INVERT:
				next_state = INVERT;
				
			default:
				next_state = START;
		endcase
	end

	// Output logic (Moore FSM output depends only on state)
	always @(posedge clk or posedge areset) begin
		if (areset)
			z <= 1'b0;
		else begin
			case (state)
				START: z <= 1'b0;
				NON_INVERT: z <= x;
				INVERT: z <= ~x;
				default: z <= 1'b0; // default case for safety
			endcase
		end
	end

endmodule
