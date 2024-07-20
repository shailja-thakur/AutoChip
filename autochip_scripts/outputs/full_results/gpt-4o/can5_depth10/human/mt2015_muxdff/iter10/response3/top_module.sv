module dff_mux(
    input clk,
    input L,
    input d,
    input r,
    output reg q
);

always @(posedge clk) begin
    if (L) begin
        q <= r;
    } else begin
        q <= d;
    }
end

endmodule
module top_module(
    input clk,
    input L,
    input [2:0] r,
    output [2:0] q
);

wire q0, q1, q2;

// Instance of dff_mux for bit 0
dff_mux dff0(
    .clk(clk),
    .L(L),
    .d(q2 ^ q1),
    .r(r[0]),
    .q(q0)
);

// Instance of dff_mux for bit 1
dff_mux dff1(
    .clk(clk),
    .L(L),
    .d(q0),
    .r(r[1]),
    .q(q1)
);

// Instance of dff_mux for bit 2
dff_mux dff2(
    .clk(clk),
    .L(L),
    .d(q1),
    .r(r[2]),
    .q(q2)
);

assign q = {q2, q1, q0};

endmodule
