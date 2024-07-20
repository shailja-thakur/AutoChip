module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

// Function: Generates a logic-1 when 2, 7, or 15 appears on the inputs
// and a logic-0 when 0, 1, 4, 5, 6, 9, 10, 13, or 14 appears.

// Output out_sop in minimum sum-of-products form
assign out_sop = (!a & !b & !c & !d) |  // 0
                (!a & !b &  c & !d) |  // 2
                (!a &  b & !c & !d) |  // 7
                ( a & !b & !c & !d) |  // 15

                ( a &  b &  c &  d);   // Don't care conditions

// Output out_pos in minimum product-of-sums form
assign out_pos = (a | b | c | d) &  // 3, 8, 11, and 12 are never present
                !(a &  b &  c &  d); // Don't care conditions

endmodule
