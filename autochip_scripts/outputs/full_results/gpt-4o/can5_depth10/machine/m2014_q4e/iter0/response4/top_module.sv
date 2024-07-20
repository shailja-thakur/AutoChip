module top_module (
    input in1,
    input in2,
    output logic out
);
    // Logic: out = ~(in1 | in2)
    assign out = ~(in1 | in2);

endmodule
