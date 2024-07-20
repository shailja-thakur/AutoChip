module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output f,
    output g
);
	reg [3:0] state, next_state;
	
	parameter A = 0,
			  B = 1,
			  S0 = 2,
			  S1 = 3,
			  S10 = 4,
			  G1 = 5,
			  G2 = 6,
			  P0 = 7,
			  P1 = 8;
			  
	always @(posedge clk or negedge resetn) begin
		if (!resetn)
			state <= A;
		else
			state <= next_state;
	end
	
	always @(state, x, y) begin
		next_state = state;
		
		case (state)
			A: if (x)
					next_state = B;
				else
					next_state = S0;
			B: next_state = S0;
			S0: if (x)
					next_state = S1;
				else
					next_state = S0;
			S1: if (x)
					next_state = S1;
				else
					next_state = S10;
			S10: if (x)
					 next_state = G1;
				  else
					 next_state = S0;
			G1: if (y)
					next_state = P1;
				else
					next_state = G2;
			G2: if (y)
					next_state = P1;
				else
					next_state = P0;
			P0: next_state = P0;
			P1: next_state = P1;
		endcase
	end
	
	assign f = (state == B);
	assign g = (state == G1 || state == G2 || state == P1);
endmodule
