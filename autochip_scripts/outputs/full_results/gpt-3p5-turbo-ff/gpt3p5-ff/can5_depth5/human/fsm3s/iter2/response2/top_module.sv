module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);
	
	reg [1:0] state_reg, state_next;

	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;

	always @(posedge clk or posedge reset)
	begin
		if (reset)
			state_reg <= A;
		else
			state_reg <= state_next;
	end

	always @(state_reg, in)
	begin
		case(state_reg)
			A: begin
				if (in)
					state_next = B;
				else
					state_next = A;
				end
			end
			
			B: begin
				if (in)
					state_next = B;
				else
					state_next = C;
				end
			end
			
			C: begin
				if (in)
					state_next = D;
				else
					state_next = A;
				end
			end
			
			D: begin
				if (in)
					state_next = B;
				else
					state_next = C;
				end
			end
		endcase
	end

	always @(posedge clk)
	begin
		case(state_reg)
			A: out = 0;
			B: out = 0;
			C: out = 0;
			D: out = 1;
		endcase
	end

endmodule
