module top_module (
	input [3:0] a, 
	input [3:0] b, 
	input [3:0] c, 
	input [3:0] d,
	input [3:0] e,
	output reg [3:0] q
);

	always @(*) begin
		case({a, b, c, d, e})
			{4'b0000, 4'b0000}: q <= 4'b1011;
			{a, b, 4'b0000, d, e}: q <= b;
			{a, b, 4'b0001, d, e}: q <= e;
			{a, b, 4'b0010, d, e}: q <= a;
			{a, b, 4'b0011, d, e}: q <= d;
			{a, b, 4'b01xx, d, e}: q <= 4'b1111;
			{a, b, 4'b10xx, d, e}: q <= 4'b1111;
			{a, b, 4'b11xx, d, e}: q <= 4'b1111;
			default: q <= 4'b1111;
		endcase
	end

endmodule
