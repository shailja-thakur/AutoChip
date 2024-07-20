module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [3:0] state, next_state; // Add reg [3:0] state and next_state to hold the current and next state respectively

parameter A = 0, B = 1, C = 2, S10 = 3, S11 = 4, S20 = 5, S21 = 6, S22 = 7; // Assign numbers to states for easy implementation

always @(posedge clk) begin
	if (reset) begin // reset condition
		state <= A; // Reset state to A
	end else begin
		state <= next_state; // Update current state with next state
	end
end

always @* begin
	case (state) // State transition logic
		A: begin
			if (s) begin
				next_state = B; // If s is asserted, next state is B
			end
			else begin
				next_state = A; // Otherwise stay in A
			end
		end
		
		B: begin
			if (w) begin
				next_state = S11; // If w is asserted, next state is S11
			end
			else begin
				next_state = S10; // Otherwise next state is S10
			end
		end
		
		C: begin
			if (w) begin
				next_state = S11; // If w is asserted, next state is S11
			end
			else begin
				next_state = S10; // Otherwise next state is S10
			end
		end
		
		S10: begin
			if (w) begin
				next_state = S21; // If w is asserted, next state is S21
			end
			else begin
				next_state = S20; // Otherwise next state is S20
			end
		end
		
		S11: begin
			if (w) begin
				next_state = S22; // If w is asserted, next state is S22
			end
			else begin
				next_state = S21; // Otherwise next state is S21
			end
		end
		
		S20: begin
			next_state = B; // Next state is B
		end
		
		S21: begin
			if (w) begin
				next_state = C; // If w is asserted, next state is C
			end
			else begin
				next_state = B; // Otherwise next state is B
			end
		end
		
		S22: begin
			if (w) begin
				next_state = B; // If w is asserted, next state is B
			end
			else begin
				next_state = C; // Otherwise next state is C
			end
		end
		
		default: begin
			next_state = A; // Default state is A
		end
	endcase
end

always @(posedge clk) begin
	if (reset) begin
		z <= 0; // Reset output
	end else begin
		case (state)
			A: begin
				z <= 0; // Set output to 0 in state A
			end
			B: begin
				z <= 0; // Set output to 0 in state B
			end
			C: begin
				z <= 0; // Set output to 0 in state C
			end
			S10: begin
				z <= 0; // Set output to 0 in state S10
			end
			S11: begin
				z <= 0; // Set output to 0 in state S11
			end
			S20: begin
				z <= 1; // Set output to 1 in state S20
			end
			S21: begin
				z <= 1; // Set output to 1 in state S21
			end
			S22: begin
				z <= 1; // Set output to 1 in state S22
			end
			default: begin
				z <= 0; // Set output to 0 by default
			end
		endcase
	end
end

endmodule
