module top_module (
	input wire do_sub,
	input wire [7:0] a,
	input wire [7:0] b,
	output reg [7:0] out,
	output reg result_is_zero
);

always @(do_sub or a or b) begin
	case (do_sub)
		0: out <= a + b;
		1: out <= a - b;
	endcase
	result_is_zero <= (out == 0);
end

endmodule
