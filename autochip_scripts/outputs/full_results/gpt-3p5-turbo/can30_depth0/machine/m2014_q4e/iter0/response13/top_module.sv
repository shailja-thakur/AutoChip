module top_module(
    input in1,
    input in2,
    output logic out
);
    
    // Combinational logic to calculate the output
    assign out = ~(in1 | in2);
    
endmodule
