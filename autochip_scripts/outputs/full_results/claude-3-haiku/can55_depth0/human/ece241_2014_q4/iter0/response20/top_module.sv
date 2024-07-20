module top_module (
    input clk,
    input x,
    output z
);

wire d1, d2, d3;
wire q1, q2, q3;
wire q1_bar, q2_bar, q3_bar;

// D flip-flop 1
assign d1 = x ^ q1;
dff dff1 (
    .clk(clk),
    .d(d1),
    .q(q1),
    .q_bar(q1_bar)
);

// D flip-flop 2
assign d2 = x & q2_bar;
dff dff2 (
    .clk(clk),
    .d(d2),
    .q(q2),
    .q_bar(q2_bar)
);

// D flip-flop 3
assign d3 = x | q3_bar;
dff dff3 (
    .clk(clk),
    .d(d3),
    .q(q3),
    .q_bar(q3_bar)
);

// XNOR gate
assign z = ~(q1 ^ q2 ^ q3);

// D flip-flop module
module dff (
    input clk,
    input d,
    output reg q,
    output reg q_bar
);

    always @(posedge clk) begin
        q <= d;
        q_bar <= ~d;
    end
endmodule
