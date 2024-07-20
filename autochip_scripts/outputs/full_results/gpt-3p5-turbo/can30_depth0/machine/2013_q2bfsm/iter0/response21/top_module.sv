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
	
	reg state_reg, next_state_reg;
	
	// Declare the outputs
	assign f = (state_reg == B) ? 1'b1 : 1'b0;
	assign g = (state_reg == G1 || state_reg == G2 || state_reg == P1) ? 1'b1 : 1'b0;
	
	// Declare the FSM logic
	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			state_reg <= A;
		end else begin
			state_reg <= next_state_reg;
		end
	end
	
	// Define the next state logic
	always @(state_reg, x, y) begin
		case (state_reg)
			A: begin
				if (x) begin
					next_state_reg = B;
				end else begin
					next_state_reg = A;
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
			P0, P1: begin
				next_state_reg = state_reg;
			end
			default: begin
				next_state_reg = A;
			end
		endcase
	end
	
endmodule
