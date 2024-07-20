module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	// Define states
	typedef enum reg {A, B} state_t;
	state_t state, next_state;

	// Sequential logic to update the state on the clock edge
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end

	// Combinatorial logic to determine next state
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
			default: next_state = A; // Default to state A if an undefined state is encountered
		endcase
	end

	// Output logic
	always @(*) begin
		if (state == B) begin
			out = 1'b1;
		end else begin
			out = 1'b0;
		end
	end

endmodule
