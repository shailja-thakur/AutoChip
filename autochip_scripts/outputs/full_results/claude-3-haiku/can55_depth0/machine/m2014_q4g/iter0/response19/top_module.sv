module top_module (
    input in1,
    input in2,
    input in3,
    output logic out
);

    logic tmp;

    assign tmp = in1 ^ in2;
    assign out = ~tmp ^ in3;

endmodule
