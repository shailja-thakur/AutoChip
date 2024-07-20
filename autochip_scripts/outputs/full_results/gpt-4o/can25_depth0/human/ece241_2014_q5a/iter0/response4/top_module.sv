module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// Declare state encoding
	typedef enum reg [1:0] {
		S0 = 2'b00,  // Initial state / Start state
		S1 = 2'b01,  // First '1' encountered
		S2 = 2'b10   // Output inversion state
	} state_t;
	
	state_t state, next_state;
	reg flip;

	// State transition logic
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= S0;
		end else begin
			state <= next_state;
		end
	end

	// Next state logic and output logic
	always @(*) begin
		next_state = state;
		z = 0;
		case (state)
			S0: begin
				z = x;  // Directly output the same input bit
				if (x == 1) begin
					next_state = S1;
				end
			end
			S1: begin
				z = ~x; // Complement the input bit
				next_state = S2;
				flip = 1;
			end
			S2: begin
				if (flip) begin
					z = ~x + 1;  // Start producing the 2's complement output
					flip = 0;
				end else begin
					z = ~x;  // Keep inverting subsequent bits
				end
			end
			default: begin
				z = 0;
				next_state = S0;
			end
		endcase
	end
endmodule
