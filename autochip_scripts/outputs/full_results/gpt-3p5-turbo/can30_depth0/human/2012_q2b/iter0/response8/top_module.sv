module top_module (
    input [5:0] y,
    input w,
    output logic Y1,
    output logic Y3
);

    assign Y1 = y[1];
    assign Y3 = y[3];

endmodule
