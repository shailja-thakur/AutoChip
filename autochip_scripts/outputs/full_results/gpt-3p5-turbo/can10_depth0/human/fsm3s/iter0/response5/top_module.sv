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

	reg [1:0] state;
	reg out_reg;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;
			out_reg <= 1'b0;
		end else begin
			case(state)
				A: begin
					if (in)
						state <= B;
					else
						state <= A;
					out_reg <= 1'b0;
				end
				B: begin
					if (in)
						state <= C;
					else
						state <= B;
					out_reg <= 1'b0;
				end
				C: begin
					if (in)
						state <= D;
					else
						state <= A;
					out_reg <= 1'b0;
				end
				D: begin
					if (in)
						state <= C;
					else
						state <= B;
					out_reg <= 1'b1;
				end
			endcase
		end
	end
	
	assign out = out_reg;
	
endmodule
