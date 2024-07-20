module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

	parameter A = 0;
	parameter B = 1;
	parameter S0 = 2;
	parameter S1 = 3;
	parameter S10 = 4;
	parameter G1 = 5;
	parameter G2 = 6;
	parameter P0 = 7;
	parameter P1 = 8;
	
	reg [2:0] state;
	reg f, g;
	
	always @(posedge clk or negedge resetn) begin
		if (~resetn)
			state <= A;
		else begin
			case(state)
				A: begin
					if (x)
						state <= B;
					else
						state <= S0;
				end
				
				B: begin
					state <= S0;
				end
				
				S0: begin
					if (x)
						state <= S1;
					else
						state <= S0;
				end
				
				S1: begin
					if (x)
						state <= S1;
					else
						state <= S10;
				end
				
				S10: begin
					if (x)
						state <= G1;
					else
						state <= S0;
				end
				
				G1: begin
					if (y)
						state <= P1;
					else
						state <= G2;
				end
				
				G2: begin
					if (y)
						state <= P1;
					else
						state <= P0;
				end
				
				P0: begin
					state <= P0;
				end
				
				P1: begin
					state <= P1;
				end
			endcase
		end
	end
	
	always @(state) begin
		f = (state == B);
		g = (state == G1) || (state == G2) || (state == P1);
	end
	
endmodule
