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
				state_next = in ? B : A;
				out = 0;
			end
			
			B: begin
				state_next = in ? B : C;
				out = 0;
			end
			
			C: begin
				state_next = in ? D : A;
				out = 0;
			end
			
			D: begin
				state_next = in ? B : C;
				out = 1;
			end
		endcase
	end

endmodule
