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
	
	reg [3:0] state_reg, next_state;
	reg [2:0] f_reg, g_reg;
	
	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			state_reg <= A;
			f_reg <= 0;
			g_reg <= 0;
		end else begin
			state_reg <= next_state;
			f_reg <= f;
			g_reg <= g;
		end
	end
	
	always_comb begin
		case (state_reg)
			A: begin
				if (x) begin
					next_state = B;
				end else begin
					next_state = A;
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
		endcase
	end

	always @(posedge clk) begin
		if (resetn == 0) begin
			f <= 0;
			g <= 0;
		end else begin
			case (state_reg)
				B: f <= 1;
				default: f <= f_reg;
			endcase

			case (state_reg)
				G1, G2, P1: g <= 1;
				default: g <= g_reg;
			endcase
		end
	end
	
endmodule
