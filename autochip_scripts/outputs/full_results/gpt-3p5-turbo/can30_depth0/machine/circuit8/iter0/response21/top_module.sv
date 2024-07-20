module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

reg q_next;

always @(negedge clock)
    q <= a;

always @(a or clock)
    if (clock)
        p <= a;

always @(posedge clock)
    q_next <= a;

always @(posedge clock)
    q <= q_next;

endmodule
