module dff_mux (
    input clk,
    input L,
    input d,    // Input to the flip-flop when L=0
    input r,    // Load input when L=1
    output reg q // Flip-flop output
);

always @(posedge clk) begin
    if (L) begin
        q <= r;
    end else begin
        q <= d;
    end
end

endmodule
module top_module (
    input [2:0] r,
    input L,
    input clk,
    output [2:0] q
);

// Instantiate the submodules for each bit
dff_mux dff_mux0 (
    .clk(clk),
    .L(L),
    .d(q[1] ^ q[2]),
    .r(r[0]),
    .q(q[0])
);

dff_mux dff_mux1 (
    .clk(clk),
    .L(L),
    .d(q[0]),
    .r(r[1]),
    .q(q[1])
);

dff_mux dff_mux2 (
    .clk(clk),
    .L(L),
    .d(q[2]),
    .r(r[2]),
    .q(q[2])
);

endmodule
