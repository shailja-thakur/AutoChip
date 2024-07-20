module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	reg [1:0] state;
	parameter B = 2'b00;
	parameter A = 2'b01;

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
		case (state)
			B: out <= 1'b0;
			A: out <= 1'b1;
		endcase
	end

endmodule
