module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

	reg [1:0] state;
	parameter B = 2'b00;
	parameter A = 2'b01;

	always @(posedge clk) begin
		if (reset) begin
			state <= B;
			out <= 1'b1;
		end else begin
			case (state)
				B: begin
					if (in == 1'b0)
						state <= A;
					else
						state <= B;
					out <= 1'b1;
				end
				A: begin
					if (in == 1'b0)
						state <= B;
					else
						state <= A;
					out <= 1'b0;
				end
			endcase
		end
	end
endmodule
