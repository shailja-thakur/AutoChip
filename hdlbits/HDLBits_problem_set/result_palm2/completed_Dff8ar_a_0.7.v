module top_module (
    input clk,
    input areset,   // active high asynchronous reset
    input [7:0] d,
    output [7:0] q
);

    DFF d0 (
        .clk(clk),
        .reset(areset),
        .d(d[0]),
        .q(q[0])
    );
    DFF d1 (
        .clk(clk),
        .reset(areset),
        .d(d[1]),
        .q(q[1])
    );
    DFF d2 (
        .clk(clk),
        .reset(areset),
        .d(d[2]),
        .q(q[2])
    );
    DFF d3 (
        .clk(clk),
        .reset(areset),
        .d(d[3]),
        .q(q[3])
    );
    DFF d4 (
        .clk(clk),
        .reset(areset),
        .d(d[4]),
        .q(q[4])
    );
    DFF d5 (
        .clk(clk),
        .reset(areset),
        .d(d[5]),
        .q(q[5])
    );
    DFF d6 (
        .clk(clk),
        .reset(areset),
        .d(d[6]),
        .q(q[6])
    );
    DFF d7 (
        .clk(clk),
        .reset(areset),
        .d(d[7]),
        .q(q[7])
    );

endmodule