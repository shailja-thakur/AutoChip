module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

    // out_sop = (c & d) | (~a & ~b & c)
    assign out_sop = (c & d) | (~a & ~b & c);
    
    wire pos0, pos1;
    
    // pos0 = c & (~b | d) & (~a | b)
    assign pos0 = c & (~b | d) & (~a | b);
    
    // pos1 = c & (~b | d) & (~a | d)
    assign pos1 = c & (~b | d) & (~a | d);
    
    // out_pos = (pos0 == pos1) ? pos0 : 1'bx
    assign out_pos = (pos0 == pos1) ? pos0 : 1'bx;

endmodule
