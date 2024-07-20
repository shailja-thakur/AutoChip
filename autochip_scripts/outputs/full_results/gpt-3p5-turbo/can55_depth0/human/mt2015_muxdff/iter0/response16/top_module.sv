module flipflop(
    input clk,
    input D,
    output reg Q
);

always @(posedge clk) begin
    Q <= D;
end

endmodule
module mux21(
    input S,
    input I0,
    input I1,
    output reg Y);

always @(S or I0 or I1) begin
    if (S == 0) begin
        Y <= I0;
    end else begin
        Y <= I1;
    end
end

endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q);

wire [2:0] q;
wire [2:0] r;

flipflop flipflop_inst1 (
    .clk(clk),
    .D(r_in),
    .Q(q[0])
);

flipflop flipflop_inst2 (
    .clk(clk),
    .D(q[1]),
    .Q(q[2])
);

flipflop flipflop_inst3 (
    .clk(clk),
    .D(q[2]),
    .Q(Q)
);

mux21 mux_inst1 (
    .S(L),
    .I0(r),
    .I1(q[1]),
    .Y(q_in)
);

endmodule
