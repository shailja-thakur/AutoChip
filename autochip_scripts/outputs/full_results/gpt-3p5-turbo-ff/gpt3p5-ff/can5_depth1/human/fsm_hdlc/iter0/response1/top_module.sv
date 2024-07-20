module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);
	
	// Define states
	typedef enum logic [2:0] {
		S0,
		S1,
		S2,
		S3,
		S4,
		S5,
		S6,
		SD
	} state_t;
	
	// Define signals
	state_t current_state, next_state;
	logic [1:0] count;
	
	// Register for current state
	always_ff @(posedge clk) begin
		if (reset) begin
			current_state <= SD;
			count <= 0;
		end
		else if (next_state != current_state) begin
			current_state <= next_state;
		end
	end
	
	// Combinational logic for next state and outputs
	always_comb begin
		next_state = current_state;
		disc = 0;
		flag = 0;
		err = 0;
		
		case (current_state)
			
			S0: begin
				if (in) begin
					next_state = S1;
					count = 1;
				end
			end
			
			S1: begin
				if (in) begin
					count = count + 1;
					if (count == 6) begin
						next_state = S2;
					end
					else if (count > 6) begin
						next_state = S3;
					end
				end
				else begin
					count = 0;
				end
			end
			
			S2: begin
				if (in) begin
					next_state = S2;
				end
				else begin
					next_state = S0;
					flag = 1;
				end
			end
			
			S3: begin
				if (in) begin
					next_state = S4;
				end
				else begin
					next_state = S0;
					disc = 1;
				end
			end
			
			S4: begin
				if (in) begin
					next_state = S5;
				end
				else begin
					next_state = S0;
					disc = 1;
				end
			end
			
			S5: begin
				if (in) begin
					next_state = S6;
				end
				else begin
					next_state = S0;
					disc = 1;
				end
			end
			
			S6: begin
				if (in) begin
					next_state = S3;
					err = 1;
				end
				else begin
					next_state = S0;
					disc = 1;
				end
			end
			
			SD: begin
				if (in) begin
					next_state = S1;
					count = 1;
				end
			end
			
		endcase
	end
	
endmodule
