module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);
    wire [8:0] sum_with_carry;

    assign sum_with_carry = a + b;
    assign s = sum_with_carry[7:0];
    assign overflow = (a[7] & b[7] & ~sum_with_carry[7]) | (~a[7] & ~b[7] & sum_with_carry[7]);
endmodule
