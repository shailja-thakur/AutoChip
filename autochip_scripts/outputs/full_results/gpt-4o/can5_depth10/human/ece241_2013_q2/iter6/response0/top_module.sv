module top_module (
    input a,
    input b,
    input c,
    input d,
    output reg out_sop,
    output reg out_pos
);

    // Compute outputs based on combinational logic
    always @(*) begin
        // Minimized sum-of-products form
        out_sop = (     (~a & ~b & c & ~d)  // 2
                     || (~a & b & c & d)    // 7
                     || (a & b & c & d)     // 15
                   );
        
        // Minimized product-of-sums form
        out_pos = (    (~a | ~b | ~c | d)    // Not 0
                    && (~a | b | ~c | d)     // Not 1
                    && (~a | b | c | ~d)     // Not 4
                    && (~a | b | c | d)      // Not 5
                    && (a | b | c | ~d)      // Not 6
                    && (a | ~b | c | d)      // Not 9
                    && (a | ~b | c | ~d)     // Not 10
                    && (~a | b | c | d)      // Not 13
                    && (~a | ~b | c | ~d)    // Not 14
                   );
    end

endmodule
