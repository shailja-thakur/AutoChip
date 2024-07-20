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

	always @*
	begin
		case(state_reg)
			A: begin
				if (in)
				begin
					state_next = B;
					out = 0;
				end
				else
				begin
					state_next = B;
					out = 0;
				end
			end
			
			B: begin
				if (in)
				begin
					state_next = C;
					out = 0;
				end
				else
				begin
					state_next = B;
					out = 0;
				end
			end
			
			C: begin
				if (in)
				begin
					state_next = D;
					out = 0;
				end
				else
				begin
					state_next = A;
					out = 0;
				end
			end
			
			D: begin
				if (in)
				begin
					state_next = B;
					out = 1;
				end
				else
				begin
					state_next = C;
					out = 1;
				end
			end
		endcase
	end

endmodule
