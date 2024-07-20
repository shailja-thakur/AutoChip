module top_module ( 
    input a, 
    input b, 
    input c, 
    input d, 
    output out_sop, 
    output out_pos 
); 
    // Minimum Sum-Of-Products (SOP) form
    assign out_sop = (~a & b & ~c & ~d) |      // 2
                     (a & b & c & ~d)  |      // 7
                     (a & b & c & d);         // 15

    // Minimum Product-Of-Sums (POS) form
    assign out_pos = (a | ~b | c | d) &       // NOT 0 
                     (a | b | c | ~d) &       // NOT 1
                     (a | b | ~c | b) &       // NOT 4
                     (a | b | ~c | d) &       // NOT 5
                     (a | b | c | ~d) &       // NOT 6
                     (a | b | ~c | ~d) &      // NOT 9
                     (a | ~b | c | b) &       // NOT 10
                     (a | ~b | ~c | ~d) &     // NOT 13
                     (a | b | ~c | ~d);       // NOT 14
endmodule
