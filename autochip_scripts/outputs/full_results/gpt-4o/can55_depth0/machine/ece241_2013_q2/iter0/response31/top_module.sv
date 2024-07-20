module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

    wire and1, and2;
    wire not_a, not_b;
    wire [1:0] pos;

    // Generating out_sop
    assign and1 = c & d;
    assign not_a = ~a;
    assign not_b = ~b;
    assign and2 = not_a & not_b & c;
    assign out_sop = and1 | and2;

    // Generating out_pos
    assign pos[0] = c & (~b | d) & (~a | b);
    assign pos[1] = c & (~b | d) & (~a | d);
    assign out_pos = (pos[0] == pos[1]) ? pos[0] : 1'bx;

endmodule
