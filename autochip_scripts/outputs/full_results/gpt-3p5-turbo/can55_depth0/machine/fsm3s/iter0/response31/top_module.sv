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

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else begin
			case (state)
				A: if (in) state <= B; else state <= A;
				B: if (in) state <= B; else state <= C;
				C: if (in) state <= D; else state <= A;
				D: if (in) state <= B; else state <= C;
			endcase
		end
	end

	assign out = (state == D) ? 1'b1 : 1'b0;
endmodule
