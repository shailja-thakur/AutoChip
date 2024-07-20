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
                (~a & ~b & d & d) | // 6
                (a & b & c & ~d) | // 7
                (a & b & d & d) | // 9
                (a & c & d & d) | // 10
                (b & c & d & d); // 13

assign out_pos = ~(a | b | c | d) & // 0
                ~(~a | b | c | d) & // 1
                ~(a | ~b | c | d) & // 2
                ~(a | b | ~c | d) & // 3
                ~(a | b | c | ~d) & // 7
                ~(~a | ~b | c | d) & // 4
                ~(~a | b | ~c | d) & // 5
                ~(~a | b | c | ~d) & // 6
                ~(a | ~b | ~c | d) & // 8
                ~(a | ~b | c | ~d) & // 9
                ~(a | b | ~c | ~d) & // 11
                ~(a | b | c | ~d); // 12

endmodule
