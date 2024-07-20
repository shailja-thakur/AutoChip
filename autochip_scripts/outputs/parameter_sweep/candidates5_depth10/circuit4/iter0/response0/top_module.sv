module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output q
);
    
    // Implementing the circuit
    assign q = a | ((~b) & c) | (d & (~c));
    
endmodule
