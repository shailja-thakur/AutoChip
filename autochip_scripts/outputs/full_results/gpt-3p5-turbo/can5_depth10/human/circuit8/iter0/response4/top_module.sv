module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

// Define the internal signals
reg state;
reg next_state;

// Define the state values
parameter S0 = 0;
parameter S1 = 1;
parameter S2 = 2;
parameter S3 = 3;

always @(posedge clock) begin
	// Next state logic
	case(state)
		S0: begin
			if (a == 1)
				next_state = S1;
			else
				next_state = S0;
		end
		S1: begin
			if (a == 0)
				next_state = S2;
			else
				next_state = S1;
		end
		S2: begin
			if (p == 1)
				next_state = S3;
			else
				next_state = S2;
		end
		S3: begin
			if (q == 1)
				next_state = S0;
			else
				next_state = S3;
		end
	endcase
	
	// Output logic
	case(state)
		S0: begin
			p <= 0;
			q <= 0;
		end
		S1: begin
			p <= 0;
			q <= 0;
		end
		S2: begin
			p <= a;
			q <= 0;
		end
		S3: begin
			p <= 0;
			q <= a;
		end
	endcase
	
	// Update the current state
	state <= next_state;
end

endmodule
