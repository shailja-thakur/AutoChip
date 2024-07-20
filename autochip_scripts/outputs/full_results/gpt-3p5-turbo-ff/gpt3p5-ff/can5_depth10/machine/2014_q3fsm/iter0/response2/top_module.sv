module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);
	
	// define states
	parameter A = 1;
	parameter B = 2;
	parameter C = 3;
	parameter S10 = 4;
	parameter S11 = 5;
	parameter S20 = 6;
	parameter S21 = 7;
	parameter S22 = 8;

	// define signals for next state logic
	reg [2:0] current_state;
	reg [2:0] next_state;
	reg [2:0] next_state_next_cycle;

	// assign current state based on reset
	always @(posedge clk or posedge reset) begin
		if (reset)
			current_state <= A;
		else
			current_state <= next_state_next_cycle;
	end

	// define next state logic
	always @* begin
		case (current_state)
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
	
	// assign next state for next cycle
	always @(posedge clk or posedge reset) begin
		if (reset)
			next_state_next_cycle <= A;
		else
			next_state_next_cycle <= next_state;
	end
	
	// assign z based on current state
	always @* begin
		case (current_state)
			B, C, S20, S21: begin
				z = 1;
			end
			default: begin
				z = 0;
			end
		endcase
	end

endmodule
