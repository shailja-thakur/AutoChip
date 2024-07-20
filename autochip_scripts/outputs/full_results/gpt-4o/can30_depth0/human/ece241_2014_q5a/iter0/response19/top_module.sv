module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// State declaration
	typedef enum reg [1:0] {
		S0, // State where we output the bits as they are until we see the first 1 (the LSB of the number)
		S1  // State where we complement the bits
	} state_t;
	
	state_t state, next_state;

	// State transition logic
	always @(posedge clk or posedge areset) begin
		if (areset) 
			state <= S0;
		else
			state <= next_state;
	end

	// Next state logic
	always @(*) begin
		case (state)
			S0: begin
				if (x == 1'b1)
					next_state = S1;
				else
					next_state = S0;
			end
			S1: begin
				next_state = S1; // Once in S1, we stay in S1
			end
			default: begin
				next_state = S0;
			end
		endcase
	end

	// Output logic
	always @(posedge clk or posedge areset) begin
		if (areset)
			z <= 1'b0;
		else begin
			case (state)
				S0: z <= x;
				S1: z <= ~x;  // Complement the bit in S1 state
				default: z <= x;
			endcase
		end
	end
endmodule
