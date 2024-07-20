module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// Define the states
	typedef enum logic [1:0] {
		A = 2'b00,
		B = 2'b01
	} state_t;
	
	state_t state, next_state;

	// State transition logic
	always_ff @(posedge clk or posedge areset) begin
		if (areset)
			state <= A;
		else
			state <= next_state;
	end

	// Next state logic
	always_comb begin
		case (state)
			A: begin
				if (x)
					next_state = B;
				else
					next_state = A;
			end
			
			B: begin
				next_state = B;
			end
			
			default: begin
				next_state = A;
			end
		endcase
	end

	// Output logic
	always_comb begin
		case (state)
			A: z = x ? 1 : 0;
			B: z = x ? 0 : 1;
			default: z = 0;
		endcase
	end

endmodule
