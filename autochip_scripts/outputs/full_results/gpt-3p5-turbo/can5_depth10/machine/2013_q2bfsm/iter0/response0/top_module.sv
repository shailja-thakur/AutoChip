module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

	// Define states
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
	} state_t;

	// Define state variables
	reg state_t current_state, next_state;

	// Define outputs
	reg f, g;

	// Define state transition logic
	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			current_state <= A;
		end else begin
			current_state <= next_state;
		end
	end

	// Define next state logic
	always @(current_state or x) begin
		case (current_state)
			A: begin
				if (x) begin
					next_state = B;
				end else begin
					next_state = S0;
				end
			end

			B: begin
				next_state = S0;
			end

			S0: begin
				if (x) begin
					next_state = S1;
				end else begin
					next_state = S0;
				end
			end

			S1: begin
				if (x) begin
					next_state = S1;
				end else begin
					next_state = S10;
				end
			end

			S10: begin
				if (x) begin
					next_state = G1;
				end else begin
					next_state = S0;
				end
			end

			G1: begin
				if (y) begin
					next_state = P1;
				end else begin
					next_state = G2;
				end
			end

			G2: begin
				if (y) begin
					next_state = P1;
				end else begin
					next_state = P0;
				end
			end

			P0: begin
				next_state = P0;
			end

			P1: begin
				next_state = P1;
			end

			default: begin
				next_state = A;
			end
		endcase
	end

	// Define output logic
	always @(current_state) begin
		case (current_state)
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
