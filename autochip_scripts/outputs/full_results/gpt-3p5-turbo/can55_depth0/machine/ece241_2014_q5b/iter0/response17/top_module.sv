module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

parameter A = 1;
parameter B = 2;

reg [1:0] state;

always @(posedge clk or posedge areset) begin
	if (areset)
		state <= A;
	else begin
		case (state)
			A: state <= (x) ? B : A;
			B: state <= B;
		endcase
	end
end

always @(posedge clk) begin
	if ((state == A && x) || (state == B && ~x))
		z <= 1;
	else
		z <= 0;
end

endmodule
