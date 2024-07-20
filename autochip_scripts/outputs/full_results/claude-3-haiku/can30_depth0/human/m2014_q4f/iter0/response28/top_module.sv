module top_module (
    input in1,
    input in2,
    output logic out
);

    logic and_out;

    // AND gate with bubbled input
    assign and_out = in1 & ~in2;

    // Connect the AND gate output to the module output
    assign out = and_out;

endmodule
