module top_module(
    input clk,
    input L,
    input [2:0] r_in,
    output reg [2:0] Q
);

wire [2:0] q_tmp;

sub_module sub_module_0 (
    .clk(clk),
    .L(L),
    .q_in(Q[0]),
    .r_in(r_in[0]),
    .Q(q_tmp[0])
);

sub_module sub_module_1 (
    .clk(clk),
    .L(L),
    .q_in(Q[1]),
    .r_in(r_in[1]),
    .Q(q_tmp[1])
);

sub_module sub_module_2 (
    .clk(clk),
    .L(L),
    .q_in(Q[2]),
    .r_in(r_in[2]),
    .Q(q_tmp[2])
);

always @(posedge clk) begin
    if (L) begin
        Q <= r_in;
    end else begin
        Q <= {q_tmp[1] ^ q_tmp[2], q_tmp[0], q_tmp[2]};
    end
end

endmodule
module sub_module(
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
