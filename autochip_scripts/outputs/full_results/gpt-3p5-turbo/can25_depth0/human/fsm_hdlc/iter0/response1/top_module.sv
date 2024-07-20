module top_module (
	input clk,
	input reset,
	input in,
	output disc,
	output flag,
	output err);
	reg [2:0] state, next_state;
	
	parameter S0 = 3'b000; // Idle state
	parameter S1 = 3'b001; // Looking for 0 after 5 consecutive 1s
	parameter S2 = 3'b010; // Looking for flag
	parameter S3 = 3'b011; // Looking for error
	parameter S4 = 3'b100; // Found disc
	parameter S5 = 3'b101; // Found flag
	parameter S6 = 3'b110; // Found error
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= S0;
		else
			state <= next_state;
	end
	
	always @(state or in) begin
		disc = 0;
		flag = 0;
		err = 0;
		next_state = state;
		
		case (state)
			S0: begin // Idle state
				if (in) next_state = S1;
			end
			
			S1: begin // Looking for 0 after 5 consecutive 1s
				if (in) begin
					if(next_state == S3 || next_state == S4)
						next_state = S6; // Found error
					else
						next_state = S2; // Looking for flag
				end else next_state = S0;
			end
			
			S2: begin // Looking for flag
				if (in) begin
					if(next_state == S3 || next_state == S6)
						next_state = S6; // Found error
				end else next_state = S5; // Found flag
			end
			
			S3: begin // Looking for error
				if (in) begin
					if(next_state == S6)
						next_state = S6; // Found error
				end else next_state = S0;
			end
			
			S4: begin // Found disc
				if (!in) next_state = S0;
			end
			
			S5: begin // Found flag
				if (!in) next_state = S0;
			end
			
			S6: begin // Found error
				if (!in) next_state = S0;
			end
			
			default: next_state = S0;
		endcase
	end
endmodule
