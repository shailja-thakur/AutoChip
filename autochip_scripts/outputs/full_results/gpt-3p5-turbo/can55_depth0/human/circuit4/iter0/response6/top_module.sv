module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
    
    // Logic to determine the value of q
    assign q = (a & ~b & ~c & ~d) | (~a & ~b & c & ~d) | (a & b & ~c & d) | (a & ~b & c & d);
    
endmodule
