module flipflop(
    input clk,
    input D,
    output reg Q
);

always @(posedge clk) begin
    Q <= D;
end

endmodule
module mux2to1(
    input S,
    input I0,
    input I1,
    output reg O
);

always @(S or I0 or I1) begin
    if (S == 0) begin
        O <= I0;
    end else begin
        O <= I1;
    end
end

endmodule
module top_module(
    input clk,
    input L,
    input q_in,
    input r_in,
    output reg Q
);

reg [2:0] q;
wire [2:0] r;

flipflop flipflop_inst (
    .clk(clk),
    .D(q_in),
    .Q(q[0])
);

mux2to1 mux1 (
    .S(r[0]),
    .I0(q[0]),
    .I1(q[2]),
    .O(r_in)
);

mux2to1 mux2 (
    .S(r[1]),
    .I0(q[0]),
    .I1(q[2]),
    .O(L)
);

mux2to1 mux3 (
    .S(r[2]),
    .I0(q[1]),
    .I1(q[2]),
    .O(q_in)
);

always @(posedge clk) begin
    if (L) begin
        q <= r;
    end else begin
        q <= {q[1] ^ q[2], q[0], q[2]};
    end
end

assign Q = q[2];

endmodule
