module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;

	reg [1:0] state_reg, state_next;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state_reg <= A;
		else
			state_reg <= state_next;
	end

	always @(state_reg or in) begin
		case (state_reg)
			A: begin
				if (in)
					state_next = B;
				else
					state_next = A;
				
				out = 1'b0;
			end
			
			B: begin
				if (in)
					state_next = B;
				else
					state_next = C;

				out = 1'b0;
			end
			
			C: begin
				if (in)
					state_next = D;
				else
					state_next = A;

				out = 1'b0;
			end
			
			D: begin
				if (in)
					state_next = B;
				else
					state_next = C;

				out = 1'b1;
			end
			
			default: state_next = A;
		endcase
	end

endmodule
