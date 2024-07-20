module top_module (
    input in1,
    input in2,
    output logic out
);

    // AND gate with in2 inverted (bubble on in2)
    assign out = in1 & ~in2;

endmodule
