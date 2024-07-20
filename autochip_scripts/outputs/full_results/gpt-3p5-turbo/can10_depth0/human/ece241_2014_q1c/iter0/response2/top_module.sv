module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

reg [8:0] temp;

always @(*) begin
	temp = a + b;
	s = temp[7:0];
	overflow = temp[8];
end

endmodule
