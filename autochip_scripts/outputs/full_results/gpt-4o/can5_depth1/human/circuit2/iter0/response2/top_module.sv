module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
    assign q = (a & b & c & d) |         // Case for 1 1 1 1
               (~a & ~b & ~c & ~d) |     // Case for 0 0 0 0
               (~a & ~b & c & d) |       // Case for 0 0 1 1
               (~a & b & ~c & d) |       // Case for 0 1 0 1
               (a & ~b & ~c & d) |       // Case for 1 0 0 1
               (a & b & ~c & ~d);        // Case for 1 1 0 0
endmodule
