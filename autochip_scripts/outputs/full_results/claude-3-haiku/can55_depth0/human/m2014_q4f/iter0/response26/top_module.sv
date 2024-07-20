module top_module (
    input in1,
    input in2,
    output logic out
);

    logic andgate;

    assign andgate = in1 & ~in2;
    assign out = andgate;

endmodule
