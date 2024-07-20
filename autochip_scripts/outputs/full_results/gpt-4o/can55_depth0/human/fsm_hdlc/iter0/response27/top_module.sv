module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);

	// State encoding
	typedef enum logic [2:0] {
		S0, S1, S2, S3, S4, S5, S6, S7, S_ERR
	} state_t;
	
	state_t state, next_state;
	
	// Sequential logic (state register)
	always_ff @(posedge clk or posedge reset) begin
		if (reset)
			state <= S0;
		else
			state <= next_state;
	end
	
	// Combinational logic (next state logic)
	always_comb begin
		// Default outputs
		next_state = state;
		disc = 0;
		flag = 0;
		err = 0;
		
		case (state)
			S0: begin
				if (in) next_state = S1;
			end
			S1: begin
				if (in) next_state = S2;
				else next_state = S0;
			end
			S2: begin
				if (in) next_state = S3;
				else next_state = S0;
			end
			S3: begin
				if (in) next_state = S4;
				else next_state = S0;
			end
			S4: begin
				if (in) next_state = S5;
				else next_state = S0;
			end
			S5: begin
				if (in) next_state = S6;
				else begin
					next_state = S0;
					disc = 1; // Detected 0111110
				end
			end
			S6: begin
				if (in) next_state = S7;
				else begin
					next_state = S0;
					flag = 1; // Detected 01111110
				end
			end
			S7: begin
				if (in) begin
					next_state = S_ERR;
					err = 1; // Detected 01111111 (7 or more 1s)
				end else
					next_state = S0;
			end
			S_ERR: begin
				err = 1; // Stay in error state
			end
			default: next_state = S0;
		endcase
	end
endmodule
