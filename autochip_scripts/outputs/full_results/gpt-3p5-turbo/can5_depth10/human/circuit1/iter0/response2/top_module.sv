module top_module (
    input a, 
    input b, 
    output q
);
    // Implementing the desired combinational circuit
    assign q = (a & !b) | (!a & b);

endmodule
