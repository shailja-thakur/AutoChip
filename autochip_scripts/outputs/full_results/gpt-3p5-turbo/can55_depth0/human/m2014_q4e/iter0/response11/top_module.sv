module top_module (
    input in1,
    input in2,
    output logic out
);
    
    // 2-input NOR gate implementation
    assign out = ~(in1 | in2);

endmodule
