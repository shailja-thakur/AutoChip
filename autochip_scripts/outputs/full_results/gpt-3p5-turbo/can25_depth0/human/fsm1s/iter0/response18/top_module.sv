module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	reg [1:0] state;
	parameter B = 2'd0;
	parameter A = 2'd1;

	always @(posedge clk or posedge reset) begin
		if (reset)
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
				default: state <= B;
			endcase
		end
	end

	always @*
		case (state)
			B: out = 1;
			A: out = 0;
			default: out = 1;
		endcase

endmodule
