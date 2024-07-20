module top_module (
    input in1,
    input in2,
    output wire out
);

    assign out = ~ (in1 | in2);

endmodule
