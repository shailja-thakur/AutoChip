module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	// define states
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	parameter E = 2'b100;
	parameter F = 2'b101;


	reg [1:0] state_reg, state_next;

	always @(posedge clk or posedge reset)
	begin
		if (reset)
			state_reg <= A;
		else
			state_reg <= state_next;
	end

	always @*
	begin
		case(state_reg)
			A:
				if(w) 
				   state_next = B;
				else 
				   state_next = A;
			B:
				if(w)
				   state_next = C;
				else 
				   state_next = D;
			C:
				if(w)
				   state_next = E;
				else 
				   state_next = D;
			D:
				if(w)
				   state_next = F;
				else 
				   state_next = A;
			E:
				if(w)
				   state_next = E;
				else 
				   state_next = D;
			F:
				if(w)
				   state_next = C;
				else 
				   state_next = D;
			default:
				state_next = A;
		endcase
	end

	always @*
	begin
		case(state_reg)
			A, D:
				z = 0;
			E, F:
				z = 1;
			default:
				z = 0;
		endcase
	end

endmodule
