module top_module (
	input wire clk,
	input wire resetn,
	input wire x,
	input wire y,
	output wire f,
	output wire g
);

	// State Definitions
	typedef enum logic [3:0] {A, B, S0, S1, S10, G1, G2, P0, P1} state_type;
	state_type present_state, next_state;
	
	// Next State Logic
	always_ff @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			present_state <= A;
		end else begin
			present_state <= next_state;
		end
	end
	
	// Output Logic
	always_comb begin
		case (present_state)
			A: begin
				f = 0;
				g = 0;
				if (x == 1) begin
					next_state = B;
				end else begin
					next_state = S0;
				end
			end
			
			B: begin
				f = 1;
				g = 0;
				next_state = S0;
			end
			
			S0: begin
				if (x == 1) begin
					next_state = S1;
				end else begin
					next_state = S0;
				end
				g = 0;
				f = 0;
			end
			
			S1: begin
				if (x == 1) begin
					next_state = S1;
				end else begin
					next_state = S10;
				end
				g = 0;
				f = 0;
			end
			
			S10: begin
				if (x == 1) begin
					next_state = G1;
				end else begin
					next_state = S0;
				end
				g = 0;
				f = 0;
			end
			
			G1: begin
				if (y == 1) begin
					next_state = P1;
				end else begin
					next_state = G2;
				end
				g = 1;
				f = 0;
			end
			
			G2: begin
				if (y == 1) begin
					next_state = P1;
				end else begin
					next_state = P0;
				end
				g = 1;
				f = 0;
			end
			
			P0: begin
				g = 0;
				f = 0;
				next_state = P0;
			end
			
			P1: begin
				g = 0;
				f = 1;
				next_state = P1;
			end
			
			default: begin
				f = 0;
				g = 0;
				next_state = A;
			end
		endcase
	end
	
endmodule
