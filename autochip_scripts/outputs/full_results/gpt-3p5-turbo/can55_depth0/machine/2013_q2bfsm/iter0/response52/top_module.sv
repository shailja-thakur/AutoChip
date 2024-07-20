module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);

	// Declare the states
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

	// Define the state register and next state logic
	reg state_reg, next_state_reg;
	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			state_reg <= A;  // Set initial state
		end else begin
			state_reg <= next_state_reg;  // Update state
		end
	end

	// Define the state transitions
	always @(state_reg or x) begin
		case (state_reg)
			A: begin
				if (x) begin
					next_state_reg = B;
				end else begin
					next_state_reg = S0;
				end
			end
			B: begin
				next_state_reg = S0;
			end
			S0: begin
				if (x) begin
					next_state_reg = S1;
				end else begin
					next_state_reg = S0;
				end
			end
			S1: begin
				if (x) begin
					next_state_reg = S1;
				end else begin
					next_state_reg = S10;
				end
			end
			S10: begin
				if (x) begin
					next_state_reg = G1;
				end else begin
					next_state_reg = S0;
				end
			end
			G1: begin
				if (y) begin
					next_state_reg = P1;
				end else begin
					next_state_reg = G2;
				end
			end
			G2: begin
				if (y) begin
					next_state_reg = P1;
				end else begin
					next_state_reg = P0;
				end
			end
			P0: begin
				next_state_reg = P0;
			end
			P1: begin
				next_state_reg = P1;
			end
		endcase
	end

	// Assign the outputs based on the current state
	always @* begin
		case (state_reg)
			B: begin
				f = 1;
			end
			G1, G2, P1: begin
				g = 1;
			end
			default: begin
				f = 0;
				g = 0;
			end
		endcase
	end

endmodule
