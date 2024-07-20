module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

reg [7:0] s;
reg overflow;

always @(*) begin
    s = a + b;
    overflow = ((a[7] & b[7] & ~s[7]) | (~a[7] & ~b[7] & s[7])) ? 1'b1 : 1'b0;
end

endmodule
