module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

	// State definitions
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
	
	// Registers
	reg state_reg;
	reg f_reg;
	reg g_reg;
	
	// Next state and output logic
	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			state_reg <= A;
			f_reg <= 0;
			g_reg <= 0;
		end else begin
			case (state_reg)
				A: begin
					state_reg <= B;
					f_reg <= 1;
				end
				B: begin
					state_reg <= S0;
					f_reg <= 0;
				end
				S0: begin
					if (x) begin
						state_reg <= S1;
					end else begin
						state_reg <= S0;
					end
				end
				S1: begin
					if (x) begin
						state_reg <= S1;
					end else begin
						state_reg <= S10;
					end
				end
				S10: begin
					if (x) begin
						state_reg <= G1;
					end else begin
						state_reg <= S0;
					end
				end
				G1: begin
					if (y) begin
						state_reg <= P1;
					end else begin
						state_reg <= G2;
					end
				end
				G2: begin
					if (y) begin
						state_reg <= P1;
					end else begin
						state_reg <= P0;
					end
				end
				P0: begin
					state_reg <= P0;
				end
				P1: begin
					state_reg <= P1;
				end
			endcase
			
			case (state_reg)
				A, B, G1, G2, P1: begin
					g_reg <= 1;
				end
				default: begin
					g_reg <= 0;
				end
			endcase
		end
	end
	
	// Output assignments
	assign f = f_reg;
	assign g = g_reg;
	
endmodule
