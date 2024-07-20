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
    end else begin
        q <= d;
    end
end

endmodule
module top_module(
    input clk,
    input L,
    input [2:0] r,
    output [2:0] q
);

wire q0, q1, q2;
wire d0, d1, d2;

// Combinational logic for data inputs to the dff_mux 
assign d0 = q1 ^ q2;
assign d1 = q0;
assign d2 = q1;

dff_mux dff0(
    .clk(clk),
    .L(L),
    .d(d0),
    .r(r[0]),
    .q(q0)
);

dff_mux dff1(
    .clk(clk),
    .L(L),
    .d(d1),
    .r(r[1]),
    .q(q1)
);

dff_mux dff2(
    .clk(clk),
    .L(L),
    .d(d2),
    .r(r[2]),
    .q(q2)
);

assign q = {q2, q1, q0};

endmodule
