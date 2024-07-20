module top_module (
    input  wire in1,
    input  wire in2,
    input  wire in3,
    output logic out
);

    logic temp;

    assign temp = in1 ^ in2;
    assign out = ~temp ^ in3;

endmodule
