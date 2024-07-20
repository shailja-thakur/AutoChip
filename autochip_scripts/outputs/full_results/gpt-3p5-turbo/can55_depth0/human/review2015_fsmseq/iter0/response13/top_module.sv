module top_module(
	input clk,
	input reset,
	input data,
	output start_shifting);

	// Define states for the finite-state machine
	parameter s0 = 2'b00;
	parameter s1 = 2'b01;
	parameter s2 = 2'b10;
	parameter s3 = 2'b11;
	
	// Define signals for state and next state
	reg [1:0] state, next_state;
	
	// Initialize state to s0
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= s0;
		end else begin
			state <= next_state;
		end
	end
	
	// Define logic for next_state and start_shifting signals
	always @(state or data) begin
		case (state)
			// State s0
			s0: begin
				if (data) begin
					next_state = s1;
				end else begin
					next_state = s0;
				end
			end
			
			// State s1
			s1: begin
				if (data) begin
					next_state = s1;
				end else begin
					next_state = s2;
				end
			end
			
			// State s2
			s2: begin
				if (data) begin
					next_state = s3;
				end else begin
					next_state = s0;
				end
			end
			
			// State s3
			s3: begin
				if (data) begin
					next_state = s1;
					start_shifting = 1;
				end else begin
					next_state = s2;
				end
			end
		endcase
	end
	
	// Initialize start_shifting to 0
	assign start_shifting = 0;
endmodule
