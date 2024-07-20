module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
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
	} state_type;
	
	// Define state signals
	reg state_reg;
	reg next_state_reg;
	
	// Define state assignments
	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			state_reg <= A;
		end else begin
			state_reg <= next_state_reg;
		end
	end

	// Define next state logic
	always_comb begin
		case(state_reg)
			A: if (x) begin
					next_state_reg = B;
				end else begin
					next_state_reg = S0;
				end
			B: next_state_reg = S0;
			S0: if (x) begin
					next_state_reg = S1;
				end else begin
					next_state_reg = S0;
				end
			S1: if (x) begin
					next_state_reg = S1;
				end else begin
					next_state_reg = S10;
				end
			S10: if (x) begin
					next_state_reg = G1;
				end else begin
					next_state_reg = S0;
				end
			G1: if (y) begin
					next_state_reg = P1;
				end else begin
					next_state_reg = G2;
				end
			G2: if (y) begin
					next_state_reg = P1;
				end else begin
					next_state_reg = P0;
				end
			P0: next_state_reg = P0;
			P1: next_state_reg = P1;
			default: next_state_reg = A;
		endcase
	end

	// Define output assignments
	always @(state_reg) begin
		case(state_reg)
			B: f = 1;
			default: f = 0;
		endcase
	end
	
	always @(state_reg) begin
		case(state_reg)
			G1, G2, P1: g = 1;
			default: g = 0;
		endcase
	end

endmodule
