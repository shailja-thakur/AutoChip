module top_module(
	input [3:1] y,
	input w,
	output reg Y2);
	reg [3:1] nextState;
	
	// Define the states
	parameter A = 3'b000;
	parameter B = 3'b001;
	parameter C = 3'b010;
	parameter D = 3'b011;
	parameter E = 3'b100;
	parameter F = 3'b101;
	
	always @(*)
	begin
		case(y)
			A:
				if(w == 1)
					nextState = B;
				else
					nextState = A;
					
			B:
				if(w == 1)
					nextState = C;
				else
					nextState = D;
					
			C:
				if(w == 1)
					nextState = E;
				else
					nextState = D;
					
			D:
				if(w == 1)
					nextState = F;
				else
					nextState = A;
					
			E:
				if(w == 1)
					nextState = E;
				else
					nextState = D;
					
			F:
				if(w == 1)
					nextState = C;
				else
					nextState = D;
					
			default:
				nextState = A;
		endcase
	end
	
	always @(posedge clk)
	begin
		y <= nextState;
	end
	
	always @(posedge clk)
	begin
		case(y)
			E, F:
				Y2 <= 1;
				
			default:
				Y2 <= 0;
		endcase
	end
endmodule
