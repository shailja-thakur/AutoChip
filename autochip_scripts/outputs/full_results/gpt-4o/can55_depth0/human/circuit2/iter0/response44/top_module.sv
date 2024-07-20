module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
    assign q = (~a & ~b & ~c) ? 1 : 
               (~a & ~b & d) ? 0 : 
               (~a & c & ~d) ? 0 : 
               (~a & c & d) ? 1 : 
               (a & ~b & ~c & ~d) ? 0 : 
               (a & ~b & ~c & d) ? 1 : 
               (a & ~b & c & ~d) ? 1 : 
               (a & ~b & c & d) ? 0 : 
               (a & b & ~c & ~d) ? 1 : 
               (a & b & ~c & d) ? 0 : 
               (a & b & c & ~d) ? 0 : 
               (a & b & c & d) ? 1 : 0;
endmodule
