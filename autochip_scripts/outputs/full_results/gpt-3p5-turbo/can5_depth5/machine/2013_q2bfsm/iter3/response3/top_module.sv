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
			A: if (resetn)
					next_state = B;
				else
					next_state = A;
			B: if (resetn)
					next_state = S0;
				else
					next_state = A;
			S0: if (resetn) begin
					if (x)
						next_state = S1;
					else
						next_state = S0;
				end else
					next_state = A;
			S1: if (resetn) begin
					if (x)
						next_state = S1;
					else
						next_state = S10;
				end else
					next_state = A;
			S10: if (resetn) begin
					if (x)
						next_state = G1;
					else
						next_state = S0;
				end else
					next_state = A;
			G1: if (resetn) begin
					if (y)
						next_state = P1;
					else
						next_state = G2;
				end else
					next_state = A;
			G2: if (resetn) begin
					if (y)
						next_state = P1;
					else
						next_state = P0;
				end else
					next_state = A;
			P0: if (resetn)
					next_state = P0;
				else
					next_state = A;
			P1: if (resetn)
					next_state = P1;
				else
					next_state = A;
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
	always_ff @(posedge clk) begin
		if (!resetn)
			begin
				f <= 0;
				g <= 0;
			end
		else begin
			case (state)
				B: f <= 1;
				G1, G2, P1: g <= 1;
				default: begin
					f <= 0;
					g <= 0;
				end
			endcase
		end
	end

endmodule
