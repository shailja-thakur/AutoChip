module top_module (
    input a, 
    input b, 
    output q
);

    // Implementing the combinational circuit
    assign q = (a & ~b) | (~a & b);

endmodule
