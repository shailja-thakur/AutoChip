module top_module (
	input clk,
	input in,
	input reset,
	output out
);
	reg [1:0] state;
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;

	always @(posedge clk, posedge reset) begin
		if (reset) begin
			state <= A;
		end else begin
			case (state)
				A: begin
					if (in)
						state <= B;
					else
						state <= A;
					out <= 0;
				end
				B: begin
					if (in)
						state <= C;
					else
						state <= B;
					out <= 0;
				end
				C: begin
					if (in)
						state <= D;
					else
						state <= A;
					out <= 0;
				end
				D: begin
					if (in)
						state <= B;
					else
						state <= C;
					out <= 1;
				end
			endcase
		end
	end

endmodule
