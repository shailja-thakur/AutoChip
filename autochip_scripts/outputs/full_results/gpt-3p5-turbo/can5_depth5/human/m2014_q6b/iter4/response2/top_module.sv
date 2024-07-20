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
	
	reg [3:1] next_state;
	
	always @(y, w)
	begin
		case(y)
			A:
				if(w == 1)
					next_state <= B;
				else
					next_state <= A;
					
			B:
				if(w == 1)
					next_state <= C;
				else
					next_state <= D;
					
			C:
				if(w == 1)
					next_state <= E;
				else
					next_state <= D;
					
			D:
				if(w == 1)
					next_state <= F;
				else
					next_state <= A;
					
			E:
				if(w == 0)
					next_state <= E;
				else
					next_state <= D;
					
			F:
				if(w == 0)
					next_state <= C;
				else
					next_state <= D;
					
			default:
				next_state <= A;
		endcase
	end
	
	always @(posedge clk)
	begin
		y <= next_state;
	end
	
	always @(next_state)
	begin
		case(next_state[2])
			0: Y2 <= 0;
			1: Y2 <= 1;
		endcase
	end
	
endmodule
