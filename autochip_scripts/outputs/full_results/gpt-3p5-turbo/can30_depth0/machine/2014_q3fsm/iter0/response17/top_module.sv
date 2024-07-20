module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

// State encoding
parameter A = 0;
parameter B = 1;
parameter C = 2;
parameter S10 = 3;
parameter S11 = 4;
parameter S20 = 5;
parameter S21 = 6;
parameter S22 = 7;

// State register
reg [2:0] state;
reg [2:0] next_state;

// Assign next state based on current state and inputs
always @(state or w) begin
	// Default next state is current state
	next_state = state;
	
	case (state)
		A: begin
			if (s)
				next_state = B;
		end
		
		B: begin
			if (w)
				next_state = S11;
			else
				next_state = S10;
		end
		
		C: begin
			if (w)
				next_state = S11;
			else
				next_state = S10;
		end
		
		S10: begin
			if (w)
				next_state = S21;
			else
				next_state = S20;
		end
		
		S11: begin
			if (w)
				next_state = S22;
			else
				next_state = S21;
		end
		
		S20: begin
			next_state = B;
		end
		
		S21: begin
			if (w)
				next_state = C;
			else
				next_state = B;
		end
		
		S22: begin
			if (w)
				next_state = B;
			else
				next_state = C;
		end
	endcase
end

// Update state on positive edge of clock
always @(posedge clk or posedge reset) begin
	if (reset)
		state <= A;
	else
		state <= next_state;
end

// Output z based on current state
always @(state) begin
	case (state)
		A: begin
			// Add logic to set z
		end
		
		B: begin
			// Add logic to set z
		end
		
		C: begin
			// Add logic to set z
		end
		
		S10: begin
			// Add logic to set z
		end
		
		S11: begin
			// Add logic to set z
		end
		
		S20: begin
			// Add logic to set z
		end
		
		S21: begin
			// Add logic to set z
		end
		
		S22: begin
			// Add logic to set z
		end
	endcase
end

endmodule
