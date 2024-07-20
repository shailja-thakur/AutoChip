module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
    
    // implementation of the circuit
    assign q = (~a & ~b & ~c & ~d) | (~a & ~b & ~c & d) | (~a & ~b & c & ~d) | (~a & ~b & c & d) |
               (~a & b & ~c & ~d) | (~a & b & ~c & d) | (~a & b & c & d) | (a & ~b & ~c & ~d) |
               (a & ~b & ~c & d) | (a & ~b & c & ~d) | (a & ~b & c & d) | (a & b & ~c & d) | 
               (a & b & c & ~d);
    
endmodule
