module top_module (
    input in1,
    input in2,
    output logic out
);
    and gate1 (in1, ~in2, out);
endmodule
