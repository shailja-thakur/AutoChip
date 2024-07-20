module top_module (
	input clk,
	input reset,
	input in,
	output reg disc,
	output reg flag,
	output reg err);

	// State encoding
	typedef enum logic [2:0] {
		S0,  // Initial state
		S1,  // Seen 0
		S2,  // Seen 01
		S3,  // Seen 011
		S4,  // Seen 0111
		S5,  // Seen 01111
		S6,  // Seen 011111
		S7,  // Seen 0111111
		S8   // Seen 01111110
	} state_t;
	
	state_t state, next_state;
	
	// Output logic
	always_ff @(posedge clk) begin
		if (reset) begin
			state <= S1;
		end else begin
			state <= next_state;
		end
	end
	
	// FSM next state logic
	always_comb begin
		next_state = state;
		disc = 0;
		flag = 0;
		err = 0;
		
		case (state)
			S1: begin  // Initial state (previous input was 0)
				if (in == 0)
					next_state = S1;
				else
					next_state = S2;
			end
			S2: begin
				if (in == 0)
					next_state = S1;
				else
					next_state = S3;
			end
			S3: begin
				if (in == 0)
					next_state = S1;
				else
					next_state = S4;
			end
			S4: begin
				if (in == 0)
					next_state = S1;
				else
					next_state = S5;
			end
			S5: begin
				if (in == 0)
					next_state = S1;
				else
					next_state = S6;
			end
			S6: begin
				if (in == 0) begin
					next_state = S7;
					disc = 1;
				end else
					next_state = S8;
			end
			S7: begin
				next_state = S1;
			end
			S8: begin
				if (in == 0) begin
					next_state = S1;
					flag = 1;
				end else
					next_state = S7;
			end
			S7: begin
				next_state = S1;
				err = 1;  // Error detected
			end
		endcase
	end
endmodule
