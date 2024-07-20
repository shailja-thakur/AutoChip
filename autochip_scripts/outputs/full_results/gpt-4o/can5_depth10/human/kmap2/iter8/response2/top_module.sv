module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);

    assign out = (~c & ~d) | // Row: 00
                 (c & ~d & ~b) | // Rows: 00, 10
                 (~d & ~a & b) | // Rows: 00, 01, part of 10
                 (d & ~a & ~b) | // Rows: 00, part of 11 
                 (d & ~c & b) | // Rows: 00, part of 11 
                 (~a & b & c) | // Row: 11 
                 (~b & c & d) | // Row: 11 
                 (a & ~b & d); // Row: 11 

endmodule
