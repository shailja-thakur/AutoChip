module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
    // Implement the combinational circuit
    assign q = (~d & a & b & c) | (~a & ~b & ~c & d);
endmodule
