module top_module (
    input logic in1,
    input logic in2,
    output logic out
);

    assign out = in1 & ~in2;

endmodule
