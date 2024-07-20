module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	parameter B = 1'b0;
	parameter A = 1'b1;

	reg state;
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= B;
		else begin
			case (state)
				B: begin
					if (in)
						state <= B;
					else
						state <= A;
				end
				A: begin
					if (in)
						state <= A;
					else
						state <= B;
				end
			endcase
		end
	end

	always @(state) begin
		if (state == A)
			out <= 1'b1;
		else
			out <= 1'b0;
	end
endmodule
