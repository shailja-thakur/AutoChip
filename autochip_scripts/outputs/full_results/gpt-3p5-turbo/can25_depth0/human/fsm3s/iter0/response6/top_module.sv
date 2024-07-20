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

	reg [1:0] state_reg;
	reg out_reg;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state_reg <= A;
		else
			case (state_reg)
				A: if (in == 1)
						state_reg <= B;
					else
						state_reg <= A;
				B: if (in == 1)
						state_reg <= B;
					else
						state_reg <= C;
				C: if (in == 1)
						state_reg <= D;
					else
						state_reg <= A;
				D: if (in == 1)
						state_reg <= B;
					else
						state_reg <= C;
			endcase
	end

	always @(state_reg) begin
		case (state_reg)
			A: out_reg <= 0;
			D: out_reg <= 1;
			default: out_reg <= 0;
		endcase
	end

	assign out = out_reg;

endmodule
