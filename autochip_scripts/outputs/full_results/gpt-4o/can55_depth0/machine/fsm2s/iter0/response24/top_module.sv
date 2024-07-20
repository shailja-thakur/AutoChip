module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

	// Define state parameters
	parameter A = 1'b0;
	parameter B = 1'b1;
	
	// State register
	reg state, next_state;

	// State transition logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A; // Reset to state A
		end else begin
			state <= next_state; // Move to next state
		end
	end

	// Next state logic
	always @(*) begin
		case (state)
			A: begin
				if (j) begin
					next_state = B;
				end else begin
					next_state = A;
				end
			end
			B: begin
				if (k) begin
					next_state = A;
				end else begin
					next_state = B;
				end
			end
			default: begin
				next_state = A; // Default to state A
			end
		endcase
	end

	// Output logic
	assign out = (state == B);

endmodule
