module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// State definition
	typedef enum logic [1:0] {
		A, B, C, D
	} state_t;

	// Module variables
	reg state_t current_state, next_state;

	// Initial state assignment
	assign current_state = A;

	// FSM logic
	always @(posedge clk, posedge reset)
	begin
		if (reset)
			next_state <= A;
		else
		begin
			case (current_state)
				A: begin
					if (in)
						next_state <= B;
					else
						next_state <= A;
				end

				B: begin
					if (in)
						next_state <= B;
					else
						next_state <= C;
				end

				C: begin
					if (in)
						next_state <= D;
					else
						next_state <= A;
				end

				D: begin
					if (in)
						next_state <= B;
					else
						next_state <= C;
				end
			endcase
		end
	end

	// Output assignment
	assign out = (current_state == D);

	// State update
	always @(posedge clk)
	begin
		current_state <= next_state;
	end

endmodule
