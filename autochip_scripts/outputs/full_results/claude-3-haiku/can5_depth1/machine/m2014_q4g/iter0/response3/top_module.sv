module top_module (
    input  logic in1,
    input  logic in2,
    input  logic in3,
    output logic out
);

    logic tmp;

    assign tmp = in1 ^ in2;
    assign out = ~tmp ^ in3;

endmodule
