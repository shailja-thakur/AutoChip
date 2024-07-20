module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	// State encoding
	typedef enum reg [2:0] {
		A, // Beginning state
		B, // output f = 1 for one clock cycle
		C, // Monitor x for sequence 101
		D, // Wait for g signal
		E, // Monitor y within two clock cycles
		F  // Maintain g
	} state_t;

	state_t state, next_state;
	reg [2:0] x_sequence;

	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			state <= A;
		else
			state <= next_state;
	end

	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			x_sequence <= 3'b000;
		else if (state == C)
			x_sequence <= {x_sequence[1:0], x};
		else
			x_sequence <= 3'b000;
	end

	always @(*) begin
		// Default output values
		f = 0;
		g = 0;

		// FSM next state logic
		case (state)
			A: begin
				if (resetn)
					next_state = B;
				else
					next_state = A;
			end
			B: begin
				f = 1;
				next_state = C;
			end
			C: begin
				if (x_sequence == 3'b101)
					next_state = D;
				else
					next_state = C;
			end
			D: begin
				g = 1;
				next_state = E;
			end
			E: begin
				g = 1;
				if (y)
					next_state = F;
				else
					next_state = D; // Wait one more cycle before deciding
			end
			F: begin
				g = 1;
			end
			default: next_state = A; // Ensure we are always in a valid state
		endcase
	end

endmodule
