module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	// Define state enumeration
	typedef enum logic [2:0] {
		A, B, C, D, E, F
	} state_type;

	// Define state and next state variables
	reg state_type current_state;
	reg state_type next_state;

	// Combinational logic for next state determination
	always @(*) begin
		case (current_state)
			A: begin
				if (w == 1'b0)
					next_state = B;
				else
					next_state = A;
			end
			B: begin
				if (w == 1'b1)
					next_state = D;
				else
					next_state = C;
			end
			C: begin
				if (w == 1'b1)
					next_state = D;
				else
					next_state = E;
			end
			D: begin
				if (w == 1'b1)
					next_state = A;
				else
					next_state = F;
			end
			E: begin
				if (w == 1'b1)
					next_state = D;
				else
					next_state = E;
			end
			F: begin
				if (w == 1'b1)
					next_state = D;
				else
					next_state = C;
			end
			default: next_state = A;
		endcase
	end

	// Sequential logic for state register update
	always @(posedge clk) begin
		if (reset)
			current_state <= A;
		else
			current_state <= next_state;
	end

	// Output logic
	assign z = (current_state == E || current_state == F) ? 1'b1 : 1'b0;

endmodule
