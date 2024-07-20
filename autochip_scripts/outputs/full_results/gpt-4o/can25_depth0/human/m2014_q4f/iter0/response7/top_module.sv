module top_module (
    input in1,
    input in2,
    output logic out
);

    // Using a NOT gate for the bubble on in2
    wire in2_not;
    assign in2_not = ~in2;

    // AND gate with in1 and in2_not
    assign out = in1 & in2_not;

endmodule
