module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

    // Minimum Sum-of-Products (SOP) Form
    assign out_sop = (~a & ~b & c & ~d) |  // 2: 0010
                     (a & b & c & ~d) |   // 7: 0111
                     (a & b & c & d);     // 15: 1111
    
    // Minimum Product-of-Sums (POS) Form
    assign out_pos = (a | ~b | ~d) &      // 0: 0000, 1: 0001
                     (a | ~c | d) &       // 4: 0100, 5: 0101
                     (~a | ~b | d) &      // 6: 0110, 9: 1001
                     (~a | c | ~d) &      // 10: 1010
                     (~a | b | c);        // 13: 1101, 14: 1110

endmodule
