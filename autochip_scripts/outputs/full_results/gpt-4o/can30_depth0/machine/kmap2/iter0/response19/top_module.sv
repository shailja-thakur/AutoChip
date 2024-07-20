module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

assign out = (~c & ~b) |  // Condition 1
             (~d & ~a) |  // Condition 2
             (a & c & d) |// Condition 3
             (b & c & d); // Condition 4

endmodule
