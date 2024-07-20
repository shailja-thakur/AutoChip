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
	
	reg state, next_state;

	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end
	
	always @(state or x) begin
		next_state = state;
		f = 0;
		g = 0;
		
		case (state)
			A: begin
				if (x) begin
					next_state = B;
				end
			end
			
			B: begin
				f = 1;
				if (x) begin
					next_state = S0;
				end
			end
			
			S0: begin
				if (x) begin
					next_state = S1;
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
				g = 1;
				if (y) begin
					next_state = P1;
				end else begin
					next_state = G2;
				end
			end
			
			G2: begin
				g = 1;
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

endmodule
