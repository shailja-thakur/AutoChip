module top_module (
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

reg [2:0] q;
wire [2:0] r;
wire L;

full_module submodule1 (
    .clk(clk),
    .L(L),
    .r(r[2:0]),
    .q(q_in[2:0])
);

full_module submodule2 (
    .clk(clk),
    .L(L),
    .r(r[2:0]),
    .q(q_in[2:0])
);

full_module submodule3 (
    .clk(clk),
    .L(L),
    .r(r[2:0]),
    .q(q_in[2:0])
);

always @(posedge clk) begin
    if (L) begin
        q <= r;
    end else begin
        q <= {q[1] ^ q[2], q[0], q[2]};
    end
end

assign r = r_in;
assign L = L;

assign Q = q[2];

endmodule
