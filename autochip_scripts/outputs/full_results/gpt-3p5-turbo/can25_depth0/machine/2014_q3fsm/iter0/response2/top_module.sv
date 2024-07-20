module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);
	
	reg [3:0] state, next_state;
	
	// Declare state assignment conditions
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end
	
	// Declare next_state assignment conditions
	always @* begin
		case(state)
			A: begin
				if (s)
					next_state = B;
				else
					next_state = state;
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
			default: begin
				next_state = state;
			end
		endcase
	end
	
	// Output assignments
	always @(posedge clk) begin
		case(state)
			A: begin
				// Fill in your logic for state A here
			end
			B: begin
				// Fill in your logic for state B here
			end
			C: begin
				// Fill in your logic for state C here
			end
			S10: begin
				// Fill in your logic for state S10 here
			end
			S11: begin
				// Fill in your logic for state S11 here
			end
			S20: begin
				// Fill in your logic for state S20 here
			end
			S21: begin
				// Fill in your logic for state S21 here
			end
			S22: begin
				// Fill in your logic for state S22 here
			end
		endcase
	end
	
endmodule
