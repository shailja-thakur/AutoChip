module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Compute outputs based on combinational logic
    assign out_sop = (     (~a & ~b & c & ~d)  // 2
                        || (~a & b & c & d)    // 7
                        || (a & b & c & d)     // 15
                      );
        
    assign out_pos = (    (~a | ~b | c)    // Not 0, 1, 4, 5, 6, 9, 10, 13, 14
                        & (b | c | ~d)    // Not 0, 1, 2, 8, 9, 10, 11, 12, 13
                      );

endmodule
