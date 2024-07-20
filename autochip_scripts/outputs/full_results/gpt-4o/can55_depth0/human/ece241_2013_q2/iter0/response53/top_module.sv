module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Sum of Products for 2, 7, 15
    assign out_sop = (~a & b & ~c & ~d)  |  // Represents 2 (0010)
                     ( a & b & c & ~d)  |  // Represents 7 (0111)
                     ( a & b & c & d) ;    // Represents 15 (1111)
                     
    // Product of Sums for 0, 1, 4, 5, 6, 9, 10, 13, or 14
    assign out_pos = ( a | b | c | ~d) &  // Represents not 0 (0000)
                     ( a | b | ~c | d) &  // Represents not 1 (0001)
                     ( a | ~b | c | d) &  // Represents not 4 (0100)
                     ( a | ~b | c | ~d) & // Represents not 5 (0101)
                     ( a | ~b | ~c | d) & // Represents not 6 (0110)
                     ( ~a | b | c | ~d) & // Represents not 9 (1001)
                     ( ~a | b | ~c | d) & // Represents not 10 (1010)
                     ( ~a | ~b | c | ~d) &// Represents not 13 (1101)
                     ( ~a | ~b | ~c | d);// Represents not 14 (1110)
                     
endmodule
