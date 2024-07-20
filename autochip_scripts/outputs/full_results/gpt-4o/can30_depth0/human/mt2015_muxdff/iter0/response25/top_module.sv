module flipflop_mux (
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
    input clk,
    input L,
    input [2:0] r,
    output [2:0] q
);

wire [2:0] q_int;

flipflop_mux ffm0(
    .clk(clk),
    .L(L),
    .q_in(r[0]),
    .r_in(r[0]),
    .Q(q_int[0])
);

flipflop_mux ffm1(
    .clk(clk),
    .L(L),
    .q_in(r[1]),
    .r_in(r[1]),
    .Q(q_int[1])
);

flipflop_mux ffm2(
    .clk(clk),
    .L(L),
    .q_in(r[2]),
    .r_in(r[2]),
    .Q(q_int[2])
);

assign q = L ? r : {q_int[1] ^ q_int[2], q_int[0], q_int[2]};

endmodule
