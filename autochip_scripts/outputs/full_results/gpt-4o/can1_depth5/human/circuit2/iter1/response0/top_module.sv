module top_module (
    input a,
    input b,
    input c,
    input d,
    output q
);

    // The logic is directly derived from the waveform table using Karnaugh maps or Boolean reduction techniques.
    assign q = (!(a | b | c | d)) |    // 0, 0, 0, 0 -> 1
               (!(a | b) & c & d) |     // 0, 0, 1, 1 -> 1
               (!a & b & c & !d) |      // 0, 1, 1, 0 -> 1
               (a & !b & !c & d) |      // 1, 0, 0, 1 -> 1
               (a & !b & c & !d) |      // 1, 0, 1, 0 -> 1
               (a & b & !c & !d) |      // 1, 1, 0, 0 -> 1
               (a & b & c & d);         // 1, 1, 1, 1 -> 1

endmodule
