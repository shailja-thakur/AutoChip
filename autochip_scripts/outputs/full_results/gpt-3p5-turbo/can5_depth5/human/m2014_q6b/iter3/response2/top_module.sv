module top_module(
	input [3:1] y,
	input w,
	output reg Y2);
	
	reg [3:1] next_state;
	
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
					next_state = B;
				else
					next_state = A;
					
			B:
				if(w == 1)
					next_state = C;
				else
					next_state = D;
					
			C:
				if(w == 1)
					next_state = E;
				else
					next_state = D;
					
			D:
				if(w == 1)
					next_state = F;
				else
					next_state = A;
					
			E:
				if(w == 1)
					next_state = E;
				else
					next_state = D;
					
			F:
				if(w == 1)
					next_state = C;
				else
					next_state = D;
					
			default:
				next_state = A;
		endcase
	end
	
	always @(posedge clk)
	begin
		y <= next_state;
	end
	
	assign Y2 = y[2];
	
endmodule
