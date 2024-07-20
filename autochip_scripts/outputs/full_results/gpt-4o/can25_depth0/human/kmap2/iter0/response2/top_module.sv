module top_module (
	input a, 
	input b,
	input c,
	input d,
	output out
);
    // Declare intermediate terms
    wire term1, term2, term3, term4, term5;
    
    // Map the K-Map terms to Boolean expressions
    assign term1 = ~c & ~d;                 // Covers cells (00, 00), (01, 00), (10, 00)
    assign term2 = ~c & b;                  // Covers cells (00, 01), (10, 01), (01, 01)
    assign term3 = d & (~a & ~b);           // Covers cell (00, 11)
    assign term4 = c & d & (~a & b);        // Covers cell (11, 10)
    assign term5 = d & (a & b);             // Covers cell (11, 11)

    // Combine terms to form the output
    assign out = term1 | term2 | term3 | term4 | term5;
endmodule
