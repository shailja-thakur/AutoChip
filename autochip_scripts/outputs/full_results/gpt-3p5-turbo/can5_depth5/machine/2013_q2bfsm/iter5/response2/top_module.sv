module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	// State enumeration
	typedef enum logic [3:0] {
		A,
		B,
		S0,
		S1,
		S10,
		G1,
		G2,
		P0,
		P1
	} state_type;

	// Declare state and next_state signals
	reg [3:0] state, next_state;

	// Declare default assignment for state signal
	initial state = A;

	// Declare next_state assignment based on current state and input signals
	always_comb begin
		case (state)
			A: next_state = B;
			B: next_state = S0;
			S0: begin
				if (x)
					next_state = S1;
				else
					next_state = S0;
			end
			S1: begin
				if (x)
					next_state = S1;
				else
					next_state = S10;
			end
			S10: begin
				if (x)
					next_state = G1;
				else
					next_state = S0;
			end
			G1: begin
				if (y)
					next_state = P1;
				else
					next_state = G2;
			end
			G2: begin
				if (y)
					next_state = P1;
				else
					next_state = P0;
			end
			P0: begin
				next_state = P0;
				f <= 0; // Reset f when in P0 state
			end
			P1: begin
				next_state = P1;
				f <= 1; // Set f when in P1 state
			end
		endcase
	end

	// Declare synchronous always block to update the state on positive edge of clk
	always @(posedge clk, negedge resetn) begin
		if (!resetn)
			state <= A;
		else
			state <= next_state;
	end

	// Output assignments based on the current state
	always @* begin
		g <= (state == G1 || state == G2 || state == P1);
	end

endmodule
