module sub_module (
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

always @(posedge clk) begin
    if (L) begin
        Q <= r_in;
    end else begin
        Q <= q_in;
    end
end

endmodule
module top_module(
    input [2:0] r,
    input L,
    input clk,
    output reg [2:0] q
);

// Internal signals to connect submodules
wire [2:0] q_intermediate;

// Instantiate the submodules
sub_module sub0 (
    .clk(clk),
    .L(L),
    .q_in(q[1] ^ q[2]),
    .r_in(r[0]),
    .Q(q_intermediate[0])
);

sub_module sub1 (
    .clk(clk),
    .L(L),
    .q_in(q[0]),
    .r_in(r[1]),
    .Q(q_intermediate[1])
);

sub_module sub2 (
    .clk(clk),
    .L(L),
    .q_in(q[2]),
    .r_in(r[2]),
    .Q(q_intermediate[2])
);

always @(posedge clk) begin
    q <= q_intermediate;
end

endmodule
