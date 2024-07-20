module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	parameter A = 0;
	parameter B = 1;
	parameter C = 2;
	parameter D = 3;

	reg [1:0] state;
	reg out_reg;

	always @(posedge clk) begin
		if (reset == 1'b1) begin
			state <= A;
			out_reg <= 1'b0;
		end else begin
			case(state)
				A: begin
					if (in == 1'b1)
						state <= B;
					else
						state <= A;
				end
				B: begin
					if (in == 1'b1)
						state <= B;
					else
						state <= C;
				end
				C: begin
					if (in == 1'b1)
						state <= D;
					else
						state <= A;
				end
				D: begin
					if (in == 1'b1)
						state <= B;
					else
						state <= C;
				end
			endcase
		end
	end

	always @(state) begin
		case(state)
			A: out_reg = 1'b0;
			B: out_reg = 1'b0;
			C: out_reg = 1'b0;
			D: out_reg = 1'b1;
		endcase
	end

	assign out = out_reg;
	
endmodule
