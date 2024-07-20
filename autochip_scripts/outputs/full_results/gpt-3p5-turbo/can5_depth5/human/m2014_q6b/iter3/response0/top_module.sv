module top_module(
	input [3:1] y,
	input w,
	output reg Y2);

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
				if(w == 0)
					Y2 <= 0;
				else
					Y2 <= 1;
					
			B:
				if(w == 0)
					Y2 <= 0;
				else
					Y2 <= 1;
					
			C:
				if(w == 0)
					Y2 <= 0;
				else
					Y2 <= 1;
					
			D:
				if(w == 1)
					Y2 <= 0;
				else
					Y2 <= 1;
					
			E:
				if(w == 1)
					Y2 <= 1;
				else
					Y2 <= 0;
					
			F:
				if(w == 0)
					Y2 <= 0;
				else
					Y2 <= 1;
					
			default:
				Y2 <= 0;
		endcase
	end
	
endmodule
