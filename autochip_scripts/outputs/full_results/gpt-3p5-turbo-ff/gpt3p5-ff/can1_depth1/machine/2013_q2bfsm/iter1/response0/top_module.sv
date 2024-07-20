module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);
	// define state enum
	typedef enum logic [3:0] {
		A, B, S0, S1, S10, G1, G2, P0, P1
	} state_t;
	
	// create state signal and initialize to A
	reg [3:0] state_reg;
	reg [3:0] next_state;
	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			state_reg <= A;
		end else begin
			state_reg <= next_state;
		end
	end
	
	// update next_state based on current state and inputs
	always @* begin
		case (state_reg)
			A: if (resetn) next_state = B; else next_state = A;
			B: if (resetn) next_state = S0; else next_state = B;
			S0: if (resetn) begin
					if (x) next_state = S1; else next_state = S0;
				end else begin
					next_state = S0;
				end
			S1: if (resetn) begin
					if (x) next_state = S1; else next_state = S10;
				end else begin
					next_state = S1;
				end
			S10: if (resetn) begin
					if (x) next_state = G1; else next_state = S0;
				end else begin
					next_state = S10;
				end
			G1: if (resetn) begin
					if (y) next_state = P1; else next_state = G2;
				end else begin
					next_state = G1;
				end
			G2: if (resetn) begin
					if (y) next_state = P1; else next_state = P0;
				end else begin
					next_state = G2;
				end
			P0: if (resetn) next_state = P0; else next_state = P0;
			P1: if (resetn) next_state = P1; else next_state = P1;
			default: next_state = A;
		endcase
	end
	
	// assign outputs based on current state
	always @(state_reg) begin
		case (state_reg)
			B: f = 1;
			G1, G2, P1: g = 1;
			default: begin
					f = 0;
					g = 0;
			end
		endcase
	end
endmodule
