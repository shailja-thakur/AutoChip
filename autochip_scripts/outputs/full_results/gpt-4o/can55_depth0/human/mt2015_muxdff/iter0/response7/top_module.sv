module top_module (
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
module full_module (
    input [2:0] r,
    input L,
    input clk,
    output [2:0] q
);

wire [2:0] Q_int; // internal wires to connect submodules
assign q = Q_int;

top_module bit0 (
    .clk(clk),
    .L(L),
    .q_in(Q_int[1] ^ Q_int[2]),
    .r_in(r[0]),
    .Q(Q_int[0])
);

top_module bit1 (
    .clk(clk),
    .L(L),
    .q_in(Q_int[0]),
    .r_in(r[1]),
    .Q(Q_int[1])
);

top_module bit2 (
    .clk(clk),
    .L(L),
    .q_in(Q_int[2]),
    .r_in(r[2]),
    .Q(Q_int[2])
);

endmodule
