module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);

    assign q = (a & ~b & c & ~d) |  // 65ns
               (a & ~b & ~c & d) |  // 60ns
               (a & ~b & ~c & ~d) | // 55ns
               (~a & b & c & ~d) |  // 45ns
               (~a & b & ~c & d) |  // 40ns
               (~a & b & ~c & ~d) | // 35ns
               (~a & ~b & c & d) |  // 30ns
               (~a & ~b & c & ~d) | // 25ns
               (~a & ~b & ~c & ~d) |// 0ns to 15ns
               (a & b & c & d) |    // 90ns
               (a & b & ~c & ~d);   // 75ns

endmodule
