module top_module (
	input a, 
	input b, 
	input c, 
	input d,
	output q
);
    // Implement the logic described by the truth table
    assign q = (~a & ~b & ~c & ~d) |
               (~a & ~b &  c &  d) |
               (~a &  b & ~c &  d) |
               (~a &  b &  c & ~d) |
               ( a & ~b & ~c &  d) |
               ( a & ~b &  c & ~d) |
               ( a &  b & ~c & ~d) |
               ( a &  b &  c &  d);
endmodule
