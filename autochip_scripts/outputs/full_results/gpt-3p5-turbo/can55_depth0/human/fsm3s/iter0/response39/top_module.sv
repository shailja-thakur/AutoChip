module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

parameter A = 2'b00;
parameter B = 2'b01;
parameter C = 2'b10;
parameter D = 2'b11;

reg [1:0] state;
reg out_next;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= A;
	else if (in)
		case (state)
			A: state <= B;
			B: state <= in ? B : C;
			C: state <= in ? D : A;
			D: state <= in ? B : C;
		endcase
	else
		state <= A;
end

always @(state) begin
	case (state)
		A: out_next = 1'b0;
		D: out_next = 1'b1;
		default: out_next = 1'b0;
	endcase
end

always @(posedge clk) begin
	out <= out_next;
end

endmodule
