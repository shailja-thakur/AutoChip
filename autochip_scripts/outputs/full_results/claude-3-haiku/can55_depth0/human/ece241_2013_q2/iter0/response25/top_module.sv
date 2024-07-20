module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

assign out_sop = (a & ~b & ~c & ~d) // 0
                | (~a & b & ~c & ~d) // 1
                | (~a & ~b & c & ~d) // 4
                | (~a & ~b & ~c & d) // 5
                | (~a & ~b & d & c) // 6
                | (a & b & c & ~d) // 7
                | (a & b & c & d); // 15

assign out_pos = (~a | ~b) & (~a | ~c) & (~a | ~d) // 0, 1, 4, 5, 6
                & (a | ~b | ~c) & (a | ~b | ~d) & (a | c | ~d) // 7, 15
                & (~a | b | c | d); // 2, 3, 8, 9, 10, 11, 12, 13, 14

endmodule
