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
	always @(posedge clk or posedge reset)
	begin
		if (reset)
			state <= A;
		else
		begin
			case (state)
				A: if (in) state <= B;
				   else state <= A;
				B: if (in) state <= B;
				   else state <= C;
				C: if (in) state <= D;
				   else state <= A;
				D: if (in) state <= B;
				   else state <= C;
			endcase
		end
	end

	assign out = (state == D) ? 1'b1 : 1'b0;

endmodule
