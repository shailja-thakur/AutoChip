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
	reg out;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= A;
		else begin
			case (state)
				A: if (in) state <= B; else state <= A;
				B: if (in) state <= B; else state <= C;
				C: if (in) state <= D; else state <= A;
				D: if (in) state <= B; else state <= C;
				default: state <= A;
			endcase
		end
	end

	always @(state) begin
		case (state)
			A: out = 0;
			D: out = 1;
			default: out = 0;
		endcase
	end

endmodule
