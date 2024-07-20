module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

assign out_sop = (a & ~b & ~c & ~d) | // 0
                (~a & b & ~c & ~d) | // 1
                (~a & ~b & c & ~d) | // 4
                (~a & ~b & ~c & d) | // 5
                (~a & ~b & d & c) | // 6
                (a & b & c & d);     // 15

assign out_pos = (~a | ~b | c | d) &
                (a | ~b | c | d) &
                (a | b | ~c | d) &
                (a | b | c | ~d);

endmodule
