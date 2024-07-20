module top_module(
    input clk,
    input in,
    output logic out
);

    reg d;
    reg q;

    always @(posedge clk)
        d <= in ^ q;

    always @(posedge clk)
        q <= d;

    assign out = q;

endmodule
