module top_module (
    input in1,
    input in2,
    output out
);
    logic nor_output;

    assign nor_output = ~(in1 | in2);
    assign out = nor_output;

endmodule
