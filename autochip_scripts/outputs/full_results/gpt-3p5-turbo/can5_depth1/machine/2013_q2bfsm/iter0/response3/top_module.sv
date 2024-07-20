module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

	// Define the states
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

	reg state, next_state;
	reg f_reg, g_reg;

	// Assign initial state
	initial begin
		state = A;
		f_reg = 0;
		g_reg = 0;
	end

	// Assign next_state and output signals based on current state and input
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			state <= A;
			f_reg <= 0;
			g_reg <= 0;
		end else begin
			state <= next_state;
			f_reg <= (state == B);
			g_reg <= (state == G1 || state == G2 || state == P1);
		end
	end

	// Define the combinational logic for next_state
	always_comb begin
		case (state)
			A: begin
				if (x)
					next_state = B;
				else
					next_state = S0;
			end
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
			P0: next_state = P0;
			P1: next_state = P1;
			default: next_state = A;
		endcase
	end

	// Assign the output signals
	assign f = f_reg;
	assign g = g_reg;

endmodule
